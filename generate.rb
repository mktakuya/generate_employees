require 'csv'
require './employee_generator'

eg = EmployeeGenerator.new

eps = []
eg.depts.each do |dept|
  eps << eg.generate(position: '部長', dept: dept).values
  eg.generate_list(10, position: '課長', dept: dept).each { |ep| eps << ep.values }
  eg.generate_list(3, position: '係長', dept: dept).each { |ep| eps << ep.values }
  eg.generate_list(120, position: 'なし', dept: dept).each { |ep| eps << ep.values }
end

csv = CSV.open('./data/output.csv', 'w')
csv.puts(eg.header)
eps.shuffle.each { |ep| csv.puts(ep) }
csv.close
