class DistancesController < ApplicationController
  def index
    areas, spots = fetch_areas_and_spots
    @all_course_list = fetch_course_lists(areas, spots)
    Distance.csv_export(areas, spots)
  end
end
