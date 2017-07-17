require 'rails_helper'

RSpec.describe "e_sal/tutorials/index", type: :view do
  before(:each) do
    assign(:e_sal_tutorials, [
      ESal::Tutorial.create!(),
      ESal::Tutorial.create!()
    ])
  end

  it "renders a list of e_sal/tutorials" do
    render
  end
end
