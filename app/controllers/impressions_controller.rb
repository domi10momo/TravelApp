class ImpressionsController < ApplicationController
  def index
    @impressions = Impression.includes(:my_schedule).order("created_at DESC")
    #@impressions = Impression.joins(:my_schedule).includes(:my_schedule).order("my_schedules.date DESC")
  end

  def new
    @choice_spot = MyTravelCourse.find(params[:format])
    @gone_date = MySchedule.find_by(id: @choice_spot.my_schedule_id).date
    @spot_name = Spot.find(@choice_spot.spot_id).name
  end

  def create
    @choice_spot = MyTravelCourse.find(params[:format])
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: params[:my_travel_course][:text],
      image: nil
    )
    redirect_to impressions_path
  end
end
