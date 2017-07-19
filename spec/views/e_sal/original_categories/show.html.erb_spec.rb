require 'rails_helper'

RSpec.describe "e_sal/original_categories/show", type: :view do
  before(:each) do
    @e_sal_original_category = assign(:e_sal_original_category, ESal::OriginalCategory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
