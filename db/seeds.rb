require 'csv'

puts 'Delete Data'
Want.delete_all
Impression.delete_all
CourseRoute.delete_all
ModelCourse.delete_all
MyTravelCourse.delete_all
Distance.delete_all
Spot.delete_all
Area.delete_all
puts 'Finished Delete'

puts 'Insert Area'
@@count = 0
begin
  CSV.foreach('db/csv_data/area.csv') do |row|
    Area.create!({ id: @@count += 1, name: row[0] })
  end
rescue ActiveRecord::RecordInvalid => e
  puts "#{e}"
  exit
end
puts 'Finish Area'

puts 'Insert Spot'
@@count = 0
begin
  # raise ActiveRecord::RecordInvalid
  CSV.foreach('db/csv_data/spot.csv') do |row|
    Spot.create!({
      id: @@count += 1,
      area_id: row[0],
      name: row[1],
      address: row[2],
      image: row[3],
      description: row[4]
    })
  end
rescue ActiveRecord::RecordInvalid => e
  puts e
  exit
end
puts 'Finish Spot'

puts "Insert Distance"
@@count = 0
CSV.foreach('db/csv_data/distance.csv') do |row|
  Distance.create!({
    id: @@count += 1,
    start_spot_id: row[0],
    end_spot_id: row[1],
    value: row[2].to_f,
    travel_time: row[3].to_i
  })
end
puts 'Finish Distance'

puts "Insert ModelCourse"
areas = Area.all
course_params = CourseParam.new()
areas.each do |area|
  path_pop = ModelCourse.init_path_array(area.spots).dup
  path_pop.sort!{|a,b| ModelCourse.path_length(a)<=>ModelCourse.path_length(b)}
  path_pop.pop(ModelCourse::INITIAL_MODELCOURSE_NUM - ModelCourse::MODELCORSES_PER_AREA_NUM)
  path_pop.each do |a_path|
    model_course = ModelCourse.create_model_courses(course_params, area, a_path)
    CourseRoute.create_course_routes(course_params, model_course, a_path)
  end
end
puts "Finish ModelCourse"