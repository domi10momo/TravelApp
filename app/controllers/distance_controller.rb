class DistanceController < ApplicationController
  def index
    areas, spots = fetch_areas_and_spots
    @distance = Distance.new()
    #@distance.csv_export(areas, spots)
    @all_course_list = @distance.get_course_list(areas, spots)
  end
end
