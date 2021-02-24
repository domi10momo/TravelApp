require "rails_helper"

RSpec.describe :course_route, type: :model do
  before :each do
    @course_route = FactoryBot.create(:course_route)
    @course = ModelCourse.find(@course_route.model_course_id)
    @spot = Spot.find(@course_route.spot_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@course_route).to be_valid
      end
    end

    context "データが異常な時" do
      it "model_course_idが存在しない場合失敗" do
        @course_route.update(model_course_id: nil)
        @course_route.valid?
        expect(@course_route.errors[:model_course]).to include("を入力してください")
      end

      it "orderが存在しない場合失敗" do
        @course_route.update(order: nil)
        @course_route.valid?
        expect(@course_route.errors[:order]).to include("は数値で入力してください")
      end

      it "spot_idが存在しない場合失敗" do
        @course_route.update(spot_id: nil)
        @course_route.valid?
        expect(@course_route.errors[:spot]).to include("を入力してください")
      end
    end

    describe "アソシエーションのテスト" do
      context "model_courseを削除した場合" do
        it "関係性を持つcourse_routeレコードも削除される" do
          @course.destroy
          @after_route = CourseRoute.find_by(id: @course_route.id)
          expect(@after_route).to_not be_present
        end
      end

      context "spotを削除した場合" do
        it "関係性を持つcourse_routeレコードも削除される" do
          @spot.destroy
          @after_route = Want.find_by(id: @course_route.id)
          expect(@after_route).to_not be_present
        end
      end
    end
  end
end
