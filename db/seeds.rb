require 'csv'

puts 'Delete Data'
CourseRoute.delete_all
ModelCourse.delete_all
MyTravelCourse.delete_all
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
    image: row[3],
    description: row[4]
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

puts "Insert ModelCourse"
areas = Area.all
@@model_course_id = 1
@@course_route_id = 0
areas.each do |area|
  spots_per_area = Spot.includes(:area).where(area_id: area.id)
  path_pop = ModelCourse.init_path_array(spots_per_area).dup
  path_pop.sort!{|a,b| ModelCourse.path_length(a)<=>ModelCourse.path_length(b)}
  path_pop.pop(ModelCourse::INITIAL_MODELCOURSE_NUM - ModelCourse::MODELCORSES_PER_AREA_NUM)
  path_pop.each do |a_path|
    model_course = ModelCourse.create_model_courses(@@model_course_id, area, a_path)
    @@course_route_id = CourseRoute.create_course_routes(@@course_route_id, model_course, a_path)
    @@model_course_id += 1
  end
end
puts "Finish ModelCourse"