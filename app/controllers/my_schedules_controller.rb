class MySchedulesController < ApplicationController
  def new
    @my_schedule = MySchedule.new
  end

  def create
    return null_date if my_schedule_params[:date].empty?

    my_schedule = MySchedule.create!(my_schedule_params)
    my_travel_course_create(my_schedule)
    redirect_to user_path(current_user)
  rescue ActiveRecord::NotNullViolation
    null_date(create_model_course_id)
  end

  def edit
    @schedule = MySchedule.find(schedule_param)
  end

  def update
    schedule = MySchedule.find(schedule_param)
    schedule.update(my_schedule_edit_params)
    redirect_to user_path(current_user)
  end

  def destroy
    schedule = MySchedule.find(schedule_param)
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

  def model_course_id
    params.require(:course_id)
  end

  def schedule_param
    params.require(:id)
  end

  def my_travel_course_create(my_schedule)
    choice_route = ModelCourse.find(model_course_id).course_routes
    choice_route.each do |spot|
      MyTravelCourse.create!(
        my_schedule_id: my_schedule.id,
        order: spot.order,
        spot_id: spot.spot_id,
        next_distance: spot.next_distance,
        next_time: spot.next_time
      )
    end
  end

  def null_date
    course = CourseRoute.find(params["course_id"])
    flash[:danger] = "日付が指定されていません。入力し直してください"
    redirect_to course_route_path(course)
  end
end
