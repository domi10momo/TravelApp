class MySchedule < ApplicationRecord
  has_many :my_travel_courses, dependent: :destroy
  belongs_to :user
  has_many :impressions
  scope :me, -> (user) { where(user_id: user.id) }
  scope :is_gone, -> (gone) { where(gone: gone) }
  scope :sort_asc, -> { order(order: "ASC").limit(5) }


  class << self
    def user_schedules(user, gone)
      me(user).is_gone(gone).to_a
    end

    def sort_order
      sort_asc
    end
  end
end
