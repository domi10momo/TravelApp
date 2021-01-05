class MySchedulesController < ApplicationController
  def new
    @my_schedule = MySchedule.new
  end
  
  def create
    if params[:date]
      my_schedule = MySchedule.create!(my_schedule_params)
    else
      redirect_to :back
    end
    choice_route = CourseRoute.where(model_course_id: params[:course_id]) 
    choice_route.each do |spot|
      MyTravelCourse.create!(
        my_schedule_id: my_schedule.id,
        order: spot.order,
        spot_id: spot.spot_id
      )
    end
    redirect_to user_path(current_user)
  end

  def edit
    @schedule = MySchedule.find(params[:id])
  end

  def update
    schedule = MySchedule.find(params[:id])
    schedule.update(my_schedule_edit_params)
    redirect_to user_path(current_user)
  end

  def destroy
    schedule = MySchedule.find(params[:id])
    schedule.destroy
    redirect_to user_path(current_user)
  end

  private
  def my_schedule_params
    params.permit(:date).merge(user_id: current_user.id)
  end

  def my_schedule_edit_params
    params.require(:my_schedule)
          .permit(:date)
          .merge(user_id: current_user.id)
  end

  def my_travel_course
    params.permit(:model_course)
  end
end