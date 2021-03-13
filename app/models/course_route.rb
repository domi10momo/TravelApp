class CourseRoute < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot
  validates :order, numericality: { greater_than_or_equal_to: 1 }

  MEASUREMENT_NUM = 2             # 距離、時間を測定する地点数

  class << self
    def create_course_routes(course_params, model_course, a_path)
      course_params.order_reset
      two_spots = Distance.new
      a_path.each_cons(MEASUREMENT_NUM).map do |start_id, end_id|
        two_spots = Distance.find_by(start_spot_id: start_id, end_spot_id: end_id).dup
        create_route(model_course, course_params, start_id, two_spots)
      end
      two_spots.value = 0
      two_spots.travel_time = 0
      create_route(model_course, course_params, a_path.last, two_spots)
    end

    def create_route(model_course, course_params, spot_id, two_spots)
      CourseRoute.create!(
        id: course_params.upper_route_id,
        model_course_id: model_course.id,
        order: course_params.upper_order_number,
        spot_id: spot_id,
        next_distance: two_spots.value,
        next_time: two_spots.travel_time
      )
    end
  end
end
