require 'csv'

puts 'Delete Data'
Distance.delete_all
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
  Spot.create({
    id: @@count += 1,
    area_id: row[0],
    name: row[1],
    address: row[2],
    description: row[3]
  })
end
puts 'Finish SPot'

puts "Insert Distance"
@@count = 0
CSV.foreach('db/csv_data/distance.csv') do |row|
  Distance.create!({
    id: @@count += 1,
    start_spot_id: row[0].to_i,
    end_spot_id: row[1].to_i,
    value: row[2].to_f,
    travel_time: row[3].to_i
  })
end
puts 'Finish Distance'