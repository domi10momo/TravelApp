require "rails_helper"

RSpec.describe :want, type: :model do
  before :each do
    @want = FactoryBot.create(:want)
    @user = User.find(@want.user_id)
    @spot = Spot.find(@want.spot_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@want).to be_valid
      end
    end

    context "データが異常な時" do
      it "user_idが存在しない場合失敗" do
        @want.update(user_id: nil)
        @want.valid?
        expect(@want.errors[:user]).to include("を入力してください")
      end

      it "spot_idが存在しない場合失敗" do
        @want.update(spot_id: nil)
        @want.valid?
        expect(@want.errors[:spot]).to include("を入力してください")
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "userを削除した場合" do
      it "関係性を持つwantsレコードも削除される" do
        @user.destroy
        @after_want = Want.find_by(id: @want.id)
        expect(@after_want).to_not be_present
      end
    end

    context "spotを削除した場合" do
      it "関係性を持つwantsレコードも削除される" do
        @spot.destroy
        @after_want = Want.find_by(id: @want.id)
        expect(@after_want).to_not be_present
      end
    end
  end
end
