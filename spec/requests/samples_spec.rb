require 'rails_helper'

RSpec.describe "Samples", type: :request do
  describe "GET /sample" do
    it "returns http success" do
      get "/sample"
      expect(response).to have_http_status(:success)
    end
  end
end
