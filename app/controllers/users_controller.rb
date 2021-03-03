class UsersController < ApplicationController
  WANT_SPOT_PER_PAGE = 4   # １ページに表示する感想数

  def show
    @spots = Spot.includes(:area)
    @want_spots = current_user.wanted_spots.page(params[:page]).per(WANT_SPOT_PER_PAGE)
    @my_schedules = current_user.my_schedules
    @my_travel_courses = MyTravelCourse.includes(:my_schedule)
  end
end
