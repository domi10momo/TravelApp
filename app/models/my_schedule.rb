class MySchedule < ApplicationRecord
  has_many :my_travel_courses
  belongs_to :user
end
