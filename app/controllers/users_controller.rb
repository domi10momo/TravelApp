class UsersController < ApplicationController
  helper_method :devided_my_travel_course
  
  def index
    @users = User.all
  end

  def show
    @spots = Spot.all_spots
    @want_spots = current_user.wanted_spots
    @my_schedules = MySchedule.where(user_id: current_user.id)
    @my_travel_courses = MyTravelCourse.includes(:my_schedule)
  end

  def devided_my_travel_course(schedule)
    @my_travel_courses.where(my_schedule_id: schedule.id)
  end
end
