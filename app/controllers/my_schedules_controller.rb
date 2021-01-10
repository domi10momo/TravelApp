class MySchedulesController < ApplicationController
  def new
    @my_schedule = MySchedule.new
  end

  def create
    if my_schedule_params[:date]
      my_schedule = MySchedule.create!(my_schedule_params)
    else
      redirect_to :back
    end
    my_travel_course_create(my_schedule)
    redirect_to user_path(current_user)
  rescue ActiveRecord::NotNullViolation
    null_date(create_model_course_id)
  end

  def edit
    @schedule = MySchedule.find(my_schedule_id)
  end

  def update
    schedule = MySchedule.find(my_schedule_id)
    schedule.update(my_schedule_edit_params)
    redirect_to user_path(current_user)
  end

  def destroy
    schedule = MySchedule.find(my_schedule_id)
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

  def create_model_course_id
    params.require(:course_id)
  end

  def my_schedule_id
    params.require(:id)
  end

  def my_travel_course_create(my_schedule)
    choice_route = CourseRoute.course(create_model_course_id)
    choice_route.each do |spot|
      MyTravelCourse.create!(
        my_schedule_id: my_schedule.id,
        order: spot.order,
        spot_id: spot.spot_id
      )
    end
  end

  def null_date(course_id)
    flash[:danger] = "日付が指定されていません。入力し直してください"
    redirect_to course_route_path(course_id)
  end
end
