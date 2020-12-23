class MyTravelCourse < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot

  class << self
    def gone_text(gone_flag)
      if gone_flag
        "旅行に行きました"
      else
        "まだ旅行に行ってません"
      end
    end
  end
end
