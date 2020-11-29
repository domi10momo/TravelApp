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
    redirect_to root_path
  end

  private
  def my_schedule_params
    params.permit(:date).merge(user_id: current_user.id)
  end

  def my_travel_course
    params.permit(:model_course)
  end
end