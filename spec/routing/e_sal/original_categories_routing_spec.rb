require "rails_helper"

RSpec.describe ESal::OriginalCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/e_sal/original_categories").to route_to("e_sal/original_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/e_sal/original_categories/new").to route_to("e_sal/original_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/e_sal/original_categories/1").to route_to("e_sal/original_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/e_sal/original_categories/1/edit").to route_to("e_sal/original_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/e_sal/original_categories").to route_to("e_sal/original_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/e_sal/original_categories/1").to route_to("e_sal/original_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/e_sal/original_categories/1").to route_to("e_sal/original_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/e_sal/original_categories/1").to route_to("e_sal/original_categories#destroy", :id => "1")
    end

  end
end
