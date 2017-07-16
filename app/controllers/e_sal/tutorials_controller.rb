class ESal::TutorialsController < ESal::Base

  def index
  end
  
  def show
  end
  
  def list
    
  end
  
  def new
    @tutorial = Tutorial.new
    get_original_categories
  end
  # alias_method :new, :build

  private
    def get_original_categories
      @original_categories = OriginalCategory.all
    end
end
