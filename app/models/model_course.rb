class ModelCourse < ApplicationRecord
  belongs_to :area
  has_many :course_routes, dependent: :destroy
  ROUTE_SPOT_NUM = 5
  INITIAL_MODELCOURSE_NUM = 1000
  MODELCORSES_PER_AREA_NUM = 100

  class << self
    # 以下で、1000コースの中から距離が短い100コースをcourse_routesテーブルへ格納
    def init_path_array(spots_per_area)
      first_id = spots_per_area.first.id
      last_id = spots_per_area.last.id
      all_population = INITIAL_MODELCOURSE_NUM.times
                                              .map { [*first_id...last_id].shuffle }
      all_population.each do |pop|
        pop.slice!(ROUTE_SPOT_NUM, last_id - first_id)
      end
      all_population
    end

    def path_length(path)
      path.each_cons(2).map do |start_id, end_id|
        Distance.find_by(start_spot_id: start_id, end_spot_id: end_id).value
      end.inject(:+)
    end

    def create_model_courses(area, a_path)
      distance = path_length(a_path)
      @@count = 0
      ModelCourse.create!(
        id: @@count += 1,
        area_id: area.id,
        score: distance,
        distance: distance
      )
    end
  end
end
