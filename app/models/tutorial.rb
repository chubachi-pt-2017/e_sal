class Tutorial < ApplicationRecord
  has_one :tutorial_content
  accepts_nested_attributes_for :tutorial_content
end
