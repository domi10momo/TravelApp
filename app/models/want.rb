class Want < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  validates :user_id, presence: true
  validates :spot_id, presence: true

  class << self
    def create_calc_course_score(model_courses, model_routes, want_spots)
      model_courses.each do |course|
        route_spot_id = model_routes.where(model_course_id: course.id).pluck(:spot_id)

        if route_spot_id.any? { |i| want_spots.ids.include?(i) }
          course.update!(score: course.distance * 0.1)
        else
          course.update!(score: course.distance)
        end
      end
      model_courses.order(score: "ASC")
    end
  end
end
