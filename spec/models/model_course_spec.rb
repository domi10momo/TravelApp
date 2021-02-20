require "rails_helper"

RSpec.describe :model_course, type: :model do
  before :each do
    @model_course = FactoryBot.create(:model_course)
    @area = Area.find(@model_course.area_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@model_course).to be_valid
      end
    end

    context "データが異常な時" do
      it "area_idが存在しない場合失敗" do
        @model_course.update(area_id: nil)
        @model_course.valid?
        expect(@model_course.errors[:area]).to include("を入力してください")
      end

      it "scoreが存在しない場合失敗" do
        @model_course.update(score: nil)
        @model_course.valid?
        expect(@model_course.errors[:score]).to include("は数値で入力してください")
      end

      it "distanceが存在しない場合失敗" do
        @model_course.update(distance: nil)
        @model_course.valid?
        expect(@model_course.errors[:distance]).to include("は数値で入力してください")
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "areaを削除した場合" do
      it "関係性を持つmodel_coursesレコードも削除される" do
        @area.destroy
        @after_model_course = ModelCourse.find_by(id: @model_course.id)
        expect(@after_model_course).to_not be_present
      end
    end
  end
end
