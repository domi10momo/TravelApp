class MyTravelCoursesController < ApplicationController
  def edit
    @travel_spots = MyTravelCourse.where(my_schedule_id: params[:id])
  end

  def update
    travel_spots = MyTravelCourse.where(my_schedule_id: params[:id])
                                 .update(my_course_edit_params)
    redirect_to user_path(current_user)
  end

  # def gone_trip

  # end

  private
  def my_course_edit_params
    params.require(:my_travel_course)
          .permit(:date)
          .merge(user_id: current_user.id)
  end
end