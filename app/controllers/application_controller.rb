class ApplicationController < ActionController::Base
  before_action :get_left_side_menu_tutorial_list

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?
  rescue_from ActionController::RoutingError, with: :render_404 unless Rails.env.development?
  rescue_from Exception, with: :render_500 unless Rails.env.development?

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'e_sal/base', content_type: 'text/html'
  end
  
  def render_500
    render template: 'errors/error_500', status: 500, layout: 'e_sal/base', content_type: 'text/html'
  end
  
  def get_left_side_menu_tutorial_list
    @side_tutorial_list = MainCategory.get_side_list
  end
end
