require "rails_helper"

RSpec.describe ESal::TutorialsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/e_sal/tutorials").to route_to("e_sal/tutorials#index")
    end

    it "routes to #new" do
      expect(:get => "/e_sal/tutorials/new").to route_to("e_sal/tutorials#new")
    end

    it "routes to #show" do
      expect(:get => "/e_sal/tutorials/1").to route_to("e_sal/tutorials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/e_sal/tutorials/1/edit").to route_to("e_sal/tutorials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/e_sal/tutorials").to route_to("e_sal/tutorials#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/e_sal/tutorials/1").to route_to("e_sal/tutorials#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/e_sal/tutorials/1").to route_to("e_sal/tutorials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/e_sal/tutorials/1").to route_to("e_sal/tutorials#destroy", :id => "1")
    end

  end
end
