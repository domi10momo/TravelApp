class Want < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  validates :user_id, presence: true
  validates :spot_id, presence: true

  class << self
    def change_score(courses, param_spot_id, weight)
      param_id = []
      param_id << param_spot_id.to_i
      courses.each do |course|
        spot_ids = course.course_routes.pluck(:spot_id)
        course.update!(score: course.score * weight) if spot_ids.any? { |i| param_id.include?(i) }
      end
    end
  end
end
