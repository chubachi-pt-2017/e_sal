require 'rails_helper'

RSpec.describe "ESal::Tutorials", type: :request do
  describe "GET /e_sal_tutorials" do
    it "works! (now write some real specs)" do
      get e_sal_tutorials_path
      expect(response).to have_http_status(200)
    end
  end
end
