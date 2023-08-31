require 'rails_helper'

RSpec.describe "ApiKeys", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/api_key/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/api_key/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api_key/update"
      expect(response).to have_http_status(:success)
    end
  end

end
