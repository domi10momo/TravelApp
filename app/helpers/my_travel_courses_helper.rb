module MyTravelCoursesHelper
  def filled_in(schedule, spot)
    Impression.find_by(my_schedule_id: schedule.id, spot_id: spot.spot_id)
  end
end
