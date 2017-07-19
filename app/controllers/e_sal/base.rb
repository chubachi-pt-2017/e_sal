class ESal::Base < ApplicationController
  before_action :authenticate_user!

end