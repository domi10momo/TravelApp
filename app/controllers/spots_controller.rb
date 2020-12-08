class SpotsController < ApplicationController
  def index
    @spots = Spot.includes(:area)
  end
end