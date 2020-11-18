class DistanceController < ApplicationController
  def index
    @distance = Distance.new()
    @areas = Area.all
    @spots = Spot.includes(:area)
    @distance.csv_export(@areas, @spots)
  end
end
