require 'rails_helper'

RSpec.describe "e_sal/tutorials/edit", type: :view do
  before(:each) do
    @e_sal_tutorial = assign(:e_sal_tutorial, ESal::Tutorial.create!())
  end

  it "renders the edit e_sal_tutorial form" do
    render

    assert_select "form[action=?][method=?]", e_sal_tutorial_path(@e_sal_tutorial), "post" do
    end
  end
end
