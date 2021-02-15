class MySchedule < ApplicationRecord
  has_many :my_travel_courses, dependent: :destroy
  belongs_to :user
  has_many :impressions, dependent: :destroy
  validates :date, presence: true
  validates :gone, , inclusion: [true, false]
  scope :me, ->(user) { where(user_id: user.id) }
  scope :gone_flag, ->(gone) { where(gone: gone) }
  scope :is_gone, ->(format) { find(format).update(gone: true) }
  scope :find_id, ->(model) { find(model.my_schedule_id) }
  scope :travel_date, ->(model) { find_id(model).date }

  class << self
    def user_schedules(user, gone)
      me(user).gone_flag(gone).to_a
    end
  end
end
