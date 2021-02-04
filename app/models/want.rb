class Want < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  validates :user_id, presence: true
  validates :spot_id, presence: true

  class << self
    def change_score(courses, routes, param_spot_id)
      param_id = []
      param_id << param_spot_id.to_i
      courses.each do |course|
        spot_ids = routes.where(model_course_id: course.id).pluck(:spot_id)
        if spot_ids.any? { |i| param_id.include?(i) }
          course.update!(score: course.score * 0.1)
        end
      end
    end
  end
end
