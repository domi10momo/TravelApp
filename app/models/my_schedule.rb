class MySchedule < ApplicationRecord
  has_many :my_travel_courses, dependent: :destroy
  belongs_to :user
  has_many :impressions, dependent: :destroy
  validates :date, presence: true
  validates :gone, inclusion: [true, false]
  scope :gone_flag, ->(gone) { where(gone: gone).to_a }
  scope :is_gone, ->(format) { find(format).update(gone: true) }
  scope :find_id, ->(model) { find(model.my_schedule_id) }
  scope :travel_date, ->(model) { find_id(model).date }
end
