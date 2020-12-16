class ModelCourse < ApplicationRecord
  belongs_to :area
  has_many :course_routes
  ROUTE_SPOT_NUM = 5
  INITIAL_MODELCOURSE_NUM = 1000
  MODELCORSES_PER_AREA_NUM = 50

  class << self
    #以下で、1000コースの中から距離が短い100コースをcourse_routesテーブルへ格納
    def init_path_array(spots_per_area)
      first_id = spots_per_area.first.id
      last_id = spots_per_area.last.id
      all_population = INITIAL_MODELCOURSE_NUM.times
                                              .map{[*first_id...last_id].shuffle}
      all_population.each do |pop|
        pop.slice!(ROUTE_SPOT_NUM, last_id - first_id)
      end
      all_population
    end

    def path_length(path)
      length = path.each_cons(2).map{|start_id, end_id|
        Distance.find_by(start_spot_id: start_id, end_spot_id: end_id).value
      }.inject(:+)
    end

    def make_model_course(areas, spots)
      areas.each do |area|
        spots_per_area = Spot.where(area_id: area.id)
        path_pop = init_path_array(spots_per_area).dup
        path_pop.sort!{|a,b| path_length(a)<=>path_length(b)}
        path_pop.pop(INITIAL_MODELCOURSE_NUM - MODELCORSES_PER_AREA_NUM)
        path_pop.each do |a_path|
          create_model_courses(area, a_path)
          create_course_routes(model_course, a_path)
        end
      end
    end

    def create_model_courses(area, a_path)
      distance = path_length(a_path)
      model_course = ModelCourse.create!(
        area_id: area.id,
        score: distance,
        distance: distance
      )
    end

    def create_course_routes(model_course, a_path)
      @@spot_count = 0
      path.each do |spot|
        CourseRoute.create!(
          model_course_id: model_course.id,
          order: @@spot_count += 1,
          spot_id: Spot.find(spot).id
        )
      end
    end
  end
end
