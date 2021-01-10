class MyTravelCourse < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
  scope :schedule_id, ->(schedule_id) { where(my_schedule_id: schedule_id).order(order: "ASC") }

  class << self
    def gone_text(gone_flag)
      return "旅行に行きました" if gone_flag

      "まだ旅行に行ってません"
    end
  end
end
