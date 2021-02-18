require "rails_helper"

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryBot.create(:user)
  end

  describe "バリデーション" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@user).to be_valid
      end

      it "iconがnilの時成功" do
        @user.update(icon: nil)
        expect(@user).to be_valid
      end
    end

    context "データが異常な時" do
      it "nicknameがnilの時失敗" do
        @user.update(nickname: nil)
        @user.valid?
        expect(@user.errors[:nickname]).to include("を入力してください")
      end

      it "emailがnilの時失敗" do
        @user.update(email: nil)
        @user.valid?
        expect(@user.errors[:email]).to include("を入力してください")
      end
    end
  end
end
