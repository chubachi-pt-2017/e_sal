require 'rails_helper'

RSpec.describe "ESal::OriginalCategories", type: :request do
  describe "GET /e_sal_original_categories" do
    it "works! (now write some real specs)" do
      get e_sal_original_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
