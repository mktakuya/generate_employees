require 'csv'
require 'gimei'

#employment_patterns = %w(正社員 契約社員 派遣社員 アルバイト)
positions = %w(専務 乗務 部長 次長 課長 係長 主任 なし)
depts = %w(経理部 営業部 製造部 販売部 開発部 人事部 財務部 総務部 企画部 情報システム部)

ARGV[0].to_i.times do
  line = []
  gimei = Gimei.new
  line.push gimei.last.kanji
  line.push gimei.first.kanji
  line.push gimei.last.hiragana
  line.push gimei.first.hiragana
  line.push gimei.male? ? '男性' : '女性'
  line.push positions.sample
  line.push rand(200..2000)
  line.push depts.sample
  puts line.join(',')
end

