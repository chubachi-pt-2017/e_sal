require 'rails_helper'

RSpec.describe "e_sal/original_categories/index", type: :view do
  before(:each) do
    assign(:e_sal_original_categories, [
      ESal::OriginalCategory.create!(),
      ESal::OriginalCategory.create!()
    ])
  end

  it "renders a list of e_sal/original_categories" do
    render
  end
end
