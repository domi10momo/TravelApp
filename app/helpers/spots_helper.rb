module SpotsHelper
  def find_spot(spots, course_spot)
    spots.find(course_spot.spot_id)
  end
end
