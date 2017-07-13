class ESal::ProgrammingsController < ESal::Base
  before_action :set_programming, only: [:show]
  
  def index
    @programmings = Programming.all
  end

  def show
  end
  
  private
  
  def set_programming
    @programming = Programming.find(params[:id])
  end
end
