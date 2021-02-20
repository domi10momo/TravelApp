require "rails_helper"

RSpec.describe :spot, type: :model do
  before :each do
    @spot = FactoryBot.create(:spot)
    @area = Area.find(@spot.area_id)
  end

  describe "バリデーションのテスト" do
    context "データが正常な時" do
      it "保存成功" do
        expect(@spot).to be_valid
      end

      it "stay_timeがnilの時成功" do
        @spot.update(stay_time: nil)
        expect(@spot).to be_valid
      end
    end

    context "データが異常な時" do
      it "nameがnilの時失敗" do
        @spot.update(name: nil)
        @spot.valid?
        expect(@spot.errors[:name]).to include("を入力してください")
      end

      it "imageがnilの時失敗" do
        @spot.update(image: nil)
        @spot.valid?
        expect(@spot.errors[:image]).to include("を入力してください")
      end

      it "descriptionがnilの時失敗" do
        @spot.update(description: nil)
        @spot.valid?
        expect(@spot.errors[:description]).to include("を入力してください")
      end

      it "addressがnilの時失敗" do
        @spot.update(address: nil)
        @spot.valid?
        expect(@spot.errors[:address]).to include("を入力してください")
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Areaインスタンス削除" do
      it("該当AreaのSpotも削除される") do
        @area.destroy
        @after_spot = Spot.find_by(id: @spot.id)
        expect(@after_spot).to_not be_present
      end
    end

    context "データが異常な時" do
      it "area_idがnilの場合失敗" do
        @spot.update(area_id: nil)
        @spot.valid?
        expect(@spot.errors[:area]).to include("を入力してください")
      end
    end
  end
end
