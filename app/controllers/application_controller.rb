class ApplicationController < ActionController::Base
  helper_method :fetch_course_lists

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def featch_course_lists(areas, spots)
    Distance.get_course_list(areas, spots)
  end

  def fetch_areas_and_spots
    areas = Area.includes(:spots)
    spots = Spot.all_spots
    return areas, spots
  end
end
