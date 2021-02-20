require "rails_helper"

RSpec.describe MySchedule, type: :model do
  before :each do
    @schedule = FactoryBot.create(:my_schedule)
    @user = User.find(@schedule.user_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@schedule).to be_valid
      end
    end

    context "データが異常な時" do
      it "user_idがnilの時失敗" do
        @schedule.update(user_id: nil)
        @schedule.valid?
        expect(@schedule.errors[:user]).to include("を入力してください")
      end

      it "dateがnilの時失敗" do
        @schedule.update(date: nil)
        @schedule.valid?
        expect(@schedule.errors[:date]).to include("を入力してください")
      end
    end

    context "gone" do
      it { is_expected.to allow_value(true).for(:gone) }
      it { is_expected.to allow_value(false).for(:gone) }
      it { is_expected.not_to allow_value(nil).for(:gone) }
    end
  end

  describe "アソシエーションのテスト" do
    context "userを削除した場合" do
      it "関係性を持つmy_scheduleレコードも削除される" do
        @user.destroy
        @after_schedule = MySchedule.find_by(id: @schedule.id)
        expect(@after_schedule).to_not be_present
      end
    end
  end
end
