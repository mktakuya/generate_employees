require 'optparse'
require 'csv'
require 'gimei'

class EmployeeGenerator
  attr_reader :positions, :depts

  def initialize
    @positions = %w(部長 課長 係長 なし)
    @depts = %w(経理部 営業部 製造部 販売部 開発部 人事部 財務部 総務部 企画部 情報システム部)
    @skills = %w(MOS 簿記3級 基本情報技術者 英検2級以上 TOEIC600点以上)
  end

  def header
    %w(姓 名 せい めい 性別 役職 部署 年齢 給与 資格)
  end

  def generate(attr = {})
    gimei = Gimei.new
    employee = {
      last_kanji: attr[:last_kanji] || gimei.last.kanji,
      first_kanji: attr[:first_kanji] || gimei.first.kanji,
      last_kana: attr[:last_kana] || gimei.last.hiragana,
      first_kana: attr[:first_kana] || gimei.first.hiragana,
      gender: attr[:gender] ||  gimei.male? ? '男性' : '女性',
      position: attr[:position] || @positions.sample,
      dept: attr[:dept] || @depts.sample,
    }
    employee[:age] = attr[:age] ||  age(attr[:position])
    employee[:salary] = attr[:salary] || salary(attr[:position])
    employee[:skills] = attr[:skills] || skills()
    return employee
  end

  def generate_list(number = 100, attr = {})
    number.times.map { self.generate(attr) }
  end

  private

  def age(position)
    case position
    when '部長'
      (55..65).to_a.sample
    when '課長'
      (45..55).to_a.sample
    when '係長'
      (35..45).to_a.sample
    else
      (20..40).to_a.sample
    end
  end

  def salary(position)
    case position
    when '部長'
      (600000..700000).to_a.sample
    when '課長'
      (500000..600000).to_a.sample
    when '係長'
      (400000..500000).to_a.sample
    else
      (200000..400000).to_a.sample
    end
  end

  def skills
    @skills.sample(rand(3)).join(' ')
  end
end
