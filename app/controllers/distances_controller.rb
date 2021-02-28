class DistancesController < ApplicationController
  def index
    @areas = Area.includes(:spots)
    @spots = Spot.includes(:area)
    @all_course_list = Distance.get_course_list(@areas, @spots)
    Distance.csv_export(@areas, @spots)
  end
end
