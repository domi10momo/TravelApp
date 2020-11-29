class ModelCoursesController < ApplicationController
  before_action :input_data, only: [:index]

  def index
    @areas, spots, @all_courses_list = featch_course_lists
    @model_courses = ModelCourse.all
  end

  def show
    areas, @spots, all_courses_list = featch_course_lists
    #選択したエリアのコースリストを選択
    @courses_in_area = all_courses_list[params[:id].to_i - 1]
    @model_courses = ModelCourse.all
  end

  private
  def input_data
    #サンプルデータを5つ作成
    ModelCourse.delete_all
    ModelCourse.create(area_id: 1, course_number: 1, score: 50, distance: 100)
    ModelCourse.create(area_id: 1, course_number: 2, score: 70, distance: 75)
    ModelCourse.create(area_id: 1, course_number: 3, score: 85, distance: 60)
    ModelCourse.create(area_id: 1, course_number: 4, score: 90, distance: 55)
    ModelCourse.create(area_id: 1, course_number: 5, score: 95, distance: 45)
  end
end