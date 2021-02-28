class MyTravelCourse < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
  validates :order, numericality: { greater_than_or_equal_to: 1 }
  validates :fill_in_impression, inclusion: [true, false]

  class << self
    def gone_text(gone_flag)
      return "旅行に行きました" if gone_flag

      "旅行予定"
    end
  end
end
