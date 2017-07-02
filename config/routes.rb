Rails.application.routes.draw do
  namespace :e_sal, :path => "e-sal" do
     get '/' => 'homes#index'
  end

end
