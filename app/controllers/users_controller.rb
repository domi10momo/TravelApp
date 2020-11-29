class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    @spots = Spot.includes(:area)
    @want_spots = @user.wanted_spots
    @my_schedules = MySchedule.where(user_id: current_user.id)
    @my_travel_courses = MyTravelCourse.where(my_schedule_id: @my_schedules.ids)
    binding.pry
  end
end
