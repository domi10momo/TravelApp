class MyTravelCourse < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
  validates :order, numericality: { greater_than_or_equal_to: 1 }
  validates :fill_in_impression, inclusion: [true, false]
end
