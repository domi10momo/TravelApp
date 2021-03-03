class ImpressionsController < ApplicationController
  MAX_IMPRESSION_NUM = 100  # 最大表示感想数
  IMPRESSION_PER_PAGE = 5   # １ページに表示する感想数

  def index
    @impressions = Impression.order(created_at: "DESC").limit(MAX_IMPRESSION_NUM)
                             .page(params[:page]).per(IMPRESSION_PER_PAGE)
  end

  def new
    @choice_spot = MyTravelCourse.find(param_format)
    @gone_date = @choice_spot.my_schedule.date
    @spot_name = @choice_spot.spot.name
  end

  def create
    return record_not_message if params_impression[:text].empty?

    @choice_spot = MyTravelCourse.find(param_format)
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: params_impression[:text],
      image: params_impression[:image]
    )
    @choice_spot.update(fill_in_impression: true)
    redirect_to impressions_path
  end

  private

  def param_format
    params.require(:format)
  end

  def params_impression
    params.require(:my_travel_course).permit(:text, :image)
  end

  def record_not_message
    flash[:danger] = "感想を入力してください。"
    redirect_to new_impression_path(param_format)
  end
end
