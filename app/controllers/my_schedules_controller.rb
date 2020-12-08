class MySchedulesController < ApplicationController
  def new
    @my_schedule = MySchedule.new
  end
  
  def create
    choice_course = my_schedule_params
    if params[:date]
      my_schedule = MySchedule.create!(my_schedule_params)
    else
      binding.pry
      redirect_to :back
    end

    choice_course = params[:model_course].split(" ")
    @@order = 0
    choice_course.each do |spot|
      MyTravelCourse.create!(
        my_schedule_id: my_schedule.id,
        order: @@order + 1,
        spot_id: spot.to_i
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
    binding.pry
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