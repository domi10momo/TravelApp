class Want < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  validates :user_id, presence: true
  validates :spot_id, presence: true
  validates :user_id, uniqueness: {
    scope: :spot_id,
    message: "は同じ観光地を行きたいに選ぶことはできません"
  }

  class << self
    def change_score(routes, param_spot_id, weight)
      routes.each do |route|
        if param_spot_id.to_i == route.spot_id
          model_course = ModelCourse.find(route.model_course_id)
          model_course.update!(score: model_course.score * weight)
        end
      end
    end
  end
end
