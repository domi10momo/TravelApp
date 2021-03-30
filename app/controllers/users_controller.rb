class UsersController < ApplicationController
  WANT_SPOT_PER_PAGE = 4   # １ページに表示する感想数
  SCHEDULE_PER_PAGE = 3   # 1ページに表示する旅行予定数
  COURSE_PER_PAGE = 3     # 1ページに表示する完了旅行数

  def show
    @spots = Spot.includes(:area)
    @want_spots = current_user.wanted_spots.page(params[:want_page]).per(WANT_SPOT_PER_PAGE)
    @my_schedules = current_user.my_schedules
    @gone_false_schedules = Kaminari.paginate_array(@my_schedules.gone_flag(false))
                                    .page(params[:not_gone_page])
                                    .per(SCHEDULE_PER_PAGE)
    @gone_true_schedules = Kaminari.paginate_array(@my_schedules.gone_flag(true))
                                   .page(params[:gone_page])
                                   .per(COURSE_PER_PAGE)
    #@my_schedules = current_user.my_schedules.page(params[:page]).per(SCHEDULE_PER_PAGE)
  end
end


#@paginatable_array = Kaminari.paginate_array(my_array_object).page(params[:page]).per(10)