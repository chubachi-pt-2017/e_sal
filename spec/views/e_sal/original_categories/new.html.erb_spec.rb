require 'rails_helper'

RSpec.describe "e_sal/original_categories/new", type: :view do
  before(:each) do
    assign(:e_sal_original_category, ESal::OriginalCategory.new())
  end

  it "renders new e_sal_original_category form" do
    render

    assert_select "form[action=?][method=?]", e_sal_original_categories_path, "post" do
    end
  end
end
