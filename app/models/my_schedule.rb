class MySchedule < ApplicationRecord
  has_many :my_travel_courses, dependent: :destroy
  belongs_to :user
  has_many :impressions, dependent: :destroy
  has_many :route_spots, through: :my_travel_courses, source: :spot
  validates :date, presence: true
  validates :gone, inclusion: [true, false]
  scope :gone_flag, ->(gone) { where(gone: gone).to_a }
  scope :find_id, ->(model) { find(model.my_schedule_id) }
  scope :route_order, ->(schedule) { find(schedule.id).my_travel_courses.preload(:spot).order(order: "ASC") }
end
