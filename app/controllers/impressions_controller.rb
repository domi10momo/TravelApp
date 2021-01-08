class ImpressionsController < ApplicationController
  def index
    @impressions = Impression.includes(:my_schedule).order("created_at DESC")
  end

  def new
    @choice_spot = MyTravelCourse.find(param_format)
    @gone_date = MySchedule.find_by(id: @choice_spot.my_schedule_id).date
    @spot_name = Spot.find(@choice_spot.spot_id).name
  end

  def create
    @choice_spot = MyTravelCourse.find(param_format)
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: param_text,
      image: nil
    )
    redirect_to impressions_path
  end

  private

    def param_format
      params.require(:format)
    end

    def param_text
      params.require(:my_travel_course)[:text]
    end
end
