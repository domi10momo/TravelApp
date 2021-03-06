class MyTravelCoursesController < ApplicationController
  COURSE_NUM = 5  # 1コースあたりの観光地数

  def show
    @spots = Spot.includes(:area)
    @schedule = MySchedule.find(my_course_params[:id])
    @course = @schedule.my_travel_courses.order(order: "ASC")
  end

  def edit
    @spots = Spot.includes(:area)
    @travel_spot = MyTravelCourse.find(my_course_params[:id])
    @course_ids = my_course_params[:course_ids]
  end

  def update
    select_course = MyTravelCourse.find(my_course_params[:course_id])
    select_course.update(spot_id: my_course_params[:spot_id])
    if select_course.id != my_course_params[:course_ids].first.to_i
      select_course_before = MyTravelCourse.find(my_course_params[:course_id].to_i - 1)
      update_distance_and_time(select_course_before, select_course_before.spot_id, select_course.spot_id)
    end
    if select_course.id != my_course_params[:course_ids].last.to_i
      select_course_next = MyTravelCourse.find(my_course_params[:course_id].to_i + 1)
      update_distance_and_time(select_course, select_course.spot_id, select_course_next.spot_id)
    end
    redirect_to user_path(current_user)
  end

  def update_distance_and_time(update_course, start_spot, end_spot)
    two_spots = Distance.fetch_next_distance_and_time(start_spot, end_spot)
    update_course.update!(
      next_distance: two_spots.value,
      next_time: two_spots.travel_time
    )
  end

  def gone_flag
    MySchedule.find(my_course_params[:format]).update(gone: true)
    redirect_to my_travel_course_path(my_course_params[:format])
  end

  private

  def my_course_params
    params.permit(:id, :course_id, :spot_id, :format, course_ids: [])
  end

  # def my_course_edit_params
  #   params.require(:my_travel_course)
  #         .permit(:date)
  #         .merge(user_id: current_user.id)
  # end
end
