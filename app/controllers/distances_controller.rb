class DistancesController < ApplicationController
  def index
    areas, spots, @all_course_list = featch_course_lists
    Distance.csv_export(areas, spots)
  end
end
