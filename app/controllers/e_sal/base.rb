class ESal::Base < ApplicationController
  before_action :authenticate_user!
   
  def get_current_user_id
    current_user.id  
  end
end