class CourseRoute < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot
  validates :order, numericality: { greater_than_or_equal_to: 1 }

  class << self
    def create_course_routes(course_route_id, model_course, a_path)
      spot_count = 0
      a_path.each do |spot|
        CourseRoute.create!(
          id: course_route_id += 1,
          model_course_id: model_course.id,
          order: spot_count += 1,
          spot_id: Spot.find(spot).id
        )
      end
      course_route_id
    end
  end
end
