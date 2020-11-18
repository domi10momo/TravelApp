require 'rails_helper'

RSpec.describe "Distances", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/distance/index"
      expect(response).to have_http_status(:success)
    end
  end

end
