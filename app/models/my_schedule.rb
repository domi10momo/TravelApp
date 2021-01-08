class MySchedule < ApplicationRecord
  has_many :my_travel_courses, dependent: :destroy
  belongs_to :user
  has_many :impressions
end
