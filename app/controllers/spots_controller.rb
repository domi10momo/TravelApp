class SpotsController < ApplicationController
  def index
    
    @spots = Spot.includes(:city)
  end
end