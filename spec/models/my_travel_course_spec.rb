require "rails_helper"

RSpec.describe MyTravelCourse, type: :model do
  before :each do
    @my_course = FactoryBot.create(:my_travel_course)
    @schedule = MySchedule.find(@my_course.my_schedule_id)
    @spot = Spot.find(@my_course.spot_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@my_course).to be_valid
      end
    end

    context "データが異常な時" do
      it "my_schedule_idがnilの時失敗" do
        @my_course.update(my_schedule_id: nil)
        @my_course.valid?
        expect(@my_course.errors[:my_schedule]).to include("を入力してください")
      end

      it "orderがnilの時失敗" do
        @my_course.update(order: nil)
        @my_course.valid?
        expect(@my_course.errors[:order]).to include("は数値で入力してください")
      end
    end

    context "fill_in_impressionのバリデーション" do
      it { is_expected.to allow_value(true).for(:fill_in_impression) }
      it { is_expected.to allow_value(false).for(:fill_in_impression) }
      it { is_expected.not_to allow_value(nil).for(:fill_in_impression) }
    end
  end

  describe "アソシエーションのテスト" do
    context "my_scheduleを削除した場合" do
      it "関係性を持つmy_travel_courseレコードも削除される" do
        @schedule.destroy
        @after_course = MyTravelCourse.find_by(id: @my_course.id)
        expect(@after_course).to_not be_present
      end
    end

    context "spotを削除した場合" do
      it "関係性を持つmy_travel_courseレコードも削除される" do
        @spot.destroy
        @after_course = MyTravelCourse.find_by(id: @my_course.id)
        expect(@after_course).to_not be_present
      end
    end
  end
end
