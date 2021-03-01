class MyTravelCoursesController < ApplicationController
  def show
    @spots = Spot.includes(:area)
    @schedule = MySchedule.find(schedule_param)
    @course = @schedule.my_travel_courses.order(order: "ASC")
  end

  def edit
    @spots = Spot.includes(:area)
    @travel_spot = MyTravelCourse.find(travel_spot_id)
  end

  def update
    MyTravelCourse.find(params[:course_id])
                  .update(spot_id: params[:spot_id])
    redirect_to user_path(current_user)
  end

  def gone_flag
    MySchedule.find(format_params).update(gone: true)
    redirect_to my_travel_course_path(format_params)
  end

  private

  def schedule_param
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
