require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #agreement" do
    it "returns http success" do
      get :agreement
      expect(response).to have_http_status(:success)
    end
  end

end
