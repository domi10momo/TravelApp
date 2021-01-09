class MyTravelCoursesController < ApplicationController
  def show
    @spots = Spot.all_spots
    @course = MyTravelCourse.schedule_id(my_schedule_id)
    @schedule = MySchedule.find(params[:id])
  end

  def edit
    @spots = Spot.all_spots
    @travel_spot = MyTravelCourse.find(travel_spot_id)
    binding.pry
  end

  def update
    binding.pry
    MyTravelCourse.find(params[:course_id])
                  .update(spot_id: params[:spot_id])
    redirect_to user_path(current_user)
  end

  def gone_flag
    MySchedule.is_gone(format_params)
    redirect_to my_travel_course_path(format_params)
  end

  private
  def my_schedule_id
    params.require(:id)
  end

  def travel_spot_id
    params.require(:id)
  end

  def my_course_edit_params
    params.require(:my_travel_course)
          .permit(:date)
          .merge(user_id: current_user.id)
  end

  def format_params
    params.require(:format)
  end
end