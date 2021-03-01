class ModelCourse < ApplicationRecord
  belongs_to :area
  has_many :course_routes, dependent: :destroy
  validates :score, numericality: { greater_than_or_equal_to: 0 }
  validates :distance, numericality: { greater_than_or_equal_to: 0 }
  ROUTE_SPOT_NUM = 5              # 1モデルコースの観光地数
  INITIAL_MODELCOURSE_NUM = 1000  # 初期ランダムで生成するモデルコース数
  MODELCORSES_PER_AREA_NUM = 100  # model_coursesテーブルに格納する地域あたりのモデルコース数

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

    def create_model_courses(model_course_id, area, a_path)
      distance = path_length(a_path)
      ModelCourse.create!(
        id: model_course_id,
        area_id: area.id,
        score: distance,
        distance: distance
      )
    end
  end
end
