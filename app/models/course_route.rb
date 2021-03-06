class CourseRoute < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot
  validates :order, numericality: { greater_than_or_equal_to: 1 }

  MEASUREMENT_NUM = 2             # 距離、時間を測定する地点数

  class << self
    def create_course_routes(course_route_id, model_course, a_path)
      spot_count = 0
      a_path.each_cons(MEASUREMENT_NUM).map do |start_id, end_id|
        two_spots = Distance.find_by(start_spot_id: start_id, end_spot_id: end_id)
        CourseRoute.create!(
          id: course_route_id += 1,
          model_course_id: model_course.id,
          order: spot_count += 1,
          spot_id: start_id,
          next_distance: two_spots.value,
          next_time: two_spots.travel_time
        )
      end
      CourseRoute.create!(
        id: course_route_id += 1,
        model_course_id: model_course.id,
        order: spot_count += 1,
        spot_id: a_path.last,
        next_distance: 0,
        next_time: 0
      )
      course_route_id
    end
  end
end
