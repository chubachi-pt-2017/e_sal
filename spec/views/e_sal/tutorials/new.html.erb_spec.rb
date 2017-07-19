require 'rails_helper'

RSpec.describe "e_sal/tutorials/new", type: :view do
  before(:each) do
    assign(:e_sal_tutorial, ESal::Tutorial.new())
  end

  it "renders new e_sal_tutorial form" do
    render

    assert_select "form[action=?][method=?]", e_sal_tutorials_path, "post" do
    end
  end
end
