class MyTravelCoursesController < ApplicationController
  def show
    @spots = Spot.includes(:area)
    @schedule = MySchedule.find(my_course_params[:id])
    @course = @schedule.my_travel_courses.order(order: "ASC")
  end

  def edit
    @spots = Spot.includes(:area)
    @travel_spot = MyTravelCourse.find(my_course_params[:id])
  end

  def update
    select_course = MyTravelCourse.find(my_course_params[:course_id])
    select_course.update(spot_id: my_course_params[:spot_id])
    if my_course_params[:course_id] % 5 != 0
      two_spots = Distance.find_by(
        start_spot_id: my_course_params[:spot_id],
        end_spot_id: MyTravelCourse.find(my_course_params[:course_id].to_i + 1).spot_id
      )
      binding.pry
      select_course.update(
        next_distance: two_spots.value,
        next_time: two_spots.travel_time
      )
    end
    redirect_to user_path(current_user)
  end

  def gone_flag
    MySchedule.find(my_course_params[:format]).update(gone: true)
    redirect_to my_travel_course_path(my_course_params[:format])
  end

  private

  def my_course_params
    params.permit(:id, :course_id, :spot_id, :format)
  end

  # def my_course_edit_params
  #   params.require(:my_travel_course)
  #         .permit(:date)
  #         .merge(user_id: current_user.id)
  # end
end
