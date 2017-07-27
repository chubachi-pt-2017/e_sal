class ESal::Base < ApplicationController

  LIST_NUM_PER_PAGE = 10

  before_action :authenticate_user!

  def get_current_user_id
    current_user.id  
  end
end