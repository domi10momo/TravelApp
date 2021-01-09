class UsersController < ApplicationController
  helper_method :devided_my_travel_course
  
  def index
    @users = User.all
  end

  def show
    @spots = Spot.all_spots
    @want_spots = current_user.wanted_spots
    @gone_true_schedules = MySchedule.user_schedules(current_user, true)
    @gone_false_schedules = MySchedule.user_schedules(current_user, false)
    @my_travel_courses = MyTravelCourse.includes(:my_schedule)
  end

  def devided_my_travel_course(schedule)
    @my_travel_courses.where(my_schedule_id: schedule.id)
  end
end
