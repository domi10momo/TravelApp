class DistanceController < ApplicationController
  def index
    areas, spots, @all_course_list = featch_course_lists
  end
end
