class MyTravelCourse < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
end
