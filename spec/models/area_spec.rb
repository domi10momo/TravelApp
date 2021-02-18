require 'rails_helper'

RSpec.describe Area, type: :model do
  before :each do
    @area = FactoryBot.create(:area)
  end

  describe "バリデーション" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@area).to be_valid
      end
    end

    context "データが異常な時" do
      it "nameがnilの時失敗" do
        @area.update(name: nil)
        @area.valid?
        expect(@area.errors[:name]).to include("を入力してください")        
      end
    end
  end
end