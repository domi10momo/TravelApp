class MyTravelCoursesController < ApplicationController
  def show
    @spots = Spot.all_spots
    @course = MyTravelCourse.where(my_schedule_id: my_schedule_id)
    @schedule = MySchedule.find(params[:id])
  end

  def edit
    @travel_spots = MyTravelCourse.where(my_schedule_id: my_schedule_id)
  end

  def update
    travel_spots = MyTravelCourse.where(my_schedule_id: my_schedule_id)
                                 .update(my_course_edit_params)
    redirect_to user_path(current_user)
  end

  def gone_flag
    MySchedule.find(format_params).update(gone: true)
    redirect_to my_travel_course_path(format_params)
  end

  private
  def my_schedule_id
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