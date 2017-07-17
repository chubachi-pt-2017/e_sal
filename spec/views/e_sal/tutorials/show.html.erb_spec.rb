require 'rails_helper'

RSpec.describe "e_sal/tutorials/show", type: :view do
  before(:each) do
    @e_sal_tutorial = assign(:e_sal_tutorial, ESal::Tutorial.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
