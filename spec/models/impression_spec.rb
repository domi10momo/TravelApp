require "rails_helper"

RSpec.describe :impression, type: :model do
  before :each do
    @impression = FactoryBot.create(:impression)
    @schedule = MySchedule.find(@impression.my_schedule_id)
    @spot = Spot.find(@impression.spot_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@impression).to be_valid
      end
    end

    context "データが異常な時" do
      it "my_schedule_idが存在しない場合失敗" do
        @impression.update(my_schedule_id: nil)
        @impression.valid?
        expect(@impression.errors[:my_schedule]).to include("を入力してください")
      end

      it "spot_idが存在しない場合失敗" do
        @impression.update(spot_id: nil)
        @impression.valid?
        expect(@impression.errors[:spot]).to include("を入力してください")
      end

      it "textが存在しない場合失敗" do
        @impression.update(text: nil)
        @impression.valid?
        expect(@impression.errors[:text]).to include("を入力してください")
      end

      it "imageが存在しない場合でも成功" do
        @impression.update(image: nil)
        expect(@impression).to be_valid
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "my_scheduleを削除した場合" do
      it "関係性を持つimpressionsレコードも削除される" do
        @schedule.destroy
        @after_impression = Impression.find_by(id: @impression.id)
        expect(@after_impression).to_not be_present
      end
    end

    context "spotを削除した場合" do
      it "関係性を持つimpressionsレコードも削除される" do
        @spot.destroy
        @after_impression = Impression.find_by(id: @impression.id)
        expect(@after_impression).to_not be_present
      end
    end
  end
end
