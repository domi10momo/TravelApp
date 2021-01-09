class CourseRoute < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot

  class << self
    def create_course_routes(model_course, a_path)
      @@spot_count = 0
      a_path.each do |spot|
        CourseRoute.create!(
          model_course_id: model_course.id,
          order: @@spot_count += 1,
          spot_id: Spot.find(spot).id
        )
      end
    end
  end
end
