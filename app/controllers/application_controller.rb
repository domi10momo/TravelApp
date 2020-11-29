class ApplicationController < ActionController::Base
  helper_method :fetch_course_lists

  def featch_course_lists
    areas, spots = fetch_areas_and_spots
    distance = Distance.new()
    return areas, spots, distance.get_course_list(areas, spots)
  end

  def fetch_areas_and_spots
    areas = Area.includes(:spots)
    spots = Spot.includes(:area)
    return areas, spots
  end
end
