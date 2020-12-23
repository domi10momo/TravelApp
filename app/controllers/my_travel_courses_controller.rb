class MyTravelCoursesController < ApplicationController
  def show
    @spots = Spot.all_spots
    @course = MyTravelCourse.where(my_schedule_id: params[:id])
    @schedule = MySchedule.find(params[:id])
  end

  def edit
    @travel_spots = MyTravelCourse.where(my_schedule_id: params[:id])
  end

  def update
    travel_spots = MyTravelCourse.where(my_schedule_id: params[:id])
                                 .update(my_course_edit_params)
    redirect_to user_path(current_user)
  end

  def gone_flag
    MySchedule.find(params[:format]).update(gone: true)
    redirect_to my_travel_course_path(params[:format])
  end

  private
  def my_course_edit_params
    params.require(:my_travel_course)
          .permit(:date)
          .merge(user_id: current_user.id)
  end
end