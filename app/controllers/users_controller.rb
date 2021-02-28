class UsersController < ApplicationController
  def show
    @spots = Spot.includes(:area)
    @want_spots = current_user.wanted_spots
    @my_schedules = current_user.my_schedules
    @my_travel_courses = MyTravelCourse.includes(:my_schedule)
  end
end
