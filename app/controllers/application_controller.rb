class ApplicationController < ActionController::Base
  helper_method :fetch_areas_and_spots

  def fetch_areas_and_spots
    areas = Area.all
    spots = Spot.includes(:area)
    return areas, spots
  end
end
