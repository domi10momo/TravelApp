require 'csv'

puts 'Delete Data'
Spot.delete_all
Area.delete_all
puts 'Finished Delete'

puts 'Insert Area'
@@count = 0
CSV.foreach('db/csv_data/area.csv') do |row|
  Area.create({ id: @@count += 1, name: row[0] })
end
puts 'Finish Area'

puts 'Insert Spot'
@@count = 0
CSV.foreach('db/csv_data/spot.csv') do |row|
  Spot.create({ id: @@count += 1, area_id: row[0], name: row[1] })
end
puts "Finish Spot"