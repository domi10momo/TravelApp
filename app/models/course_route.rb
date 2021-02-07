class CourseRoute < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot
  scope :course_ids, ->(course) { where(model_course_id: course.ids) }
  scope :course, ->(course_id) { where(model_course_id: course_id) }

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
    end
  end
end
