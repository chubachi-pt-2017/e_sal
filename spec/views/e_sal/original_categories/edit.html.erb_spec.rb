require 'rails_helper'

RSpec.describe "e_sal/original_categories/edit", type: :view do
  before(:each) do
    @e_sal_original_category = assign(:e_sal_original_category, ESal::OriginalCategory.create!())
  end

  it "renders the edit e_sal_original_category form" do
    render

    assert_select "form[action=?][method=?]", e_sal_original_category_path(@e_sal_original_category), "post" do
    end
  end
end
