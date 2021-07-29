class ImpressionsController < ApplicationController
  MAX_IMPRESSION_NUM = 100  # 最大表示感想数
  IMPRESSION_PER_PAGE = 5   # １ページに表示する感想数

  def index
    @impressions = Impression.eager_load(:spot, :my_schedule).order(created_at: "DESC").limit(MAX_IMPRESSION_NUM)
                             .page(params[:page]).per(IMPRESSION_PER_PAGE)
  end

  def new
    @choice_spot = MyTravelCourse.eager_load(:my_schedule, :spot).find(param_format)
  end

  def create
    @choice_spot = MyTravelCourse.eager_load(:my_schedule, :spot).find(param_format)
      Impression.create!(
        my_schedule_id: @choice_spot.my_schedule_id,
        spot_id: @choice_spot.spot_id,
        text: params_impression[:text],
        image: params_impression[:image]
      )

    @choice_spot.update(fill_in_impression: true)
    redirect_to impressions_path
  rescue ActiveRecord::RecordInvalid => e
    flash[:danger] = "感想は10文字以上200文字以内で入力してください"
    redirect_to new_impression_path(param_format)
  end

  private

  def param_format
    params.require(:format)
  end

  def params_impression
    params.require(:my_travel_course).permit(:text, :image)
  end
end
