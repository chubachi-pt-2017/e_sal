Rails.application.routes.draw do
  
  root 'home#index'
  
  get "/agreement" => "home#agreement", as: :agreement

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    unlocks: "users/unlocks"
  }
  
  devise_scope :user do 
    patch "users/confirmation", to: "users/confirmations#confirm"
    get "users/thanks", to: "users/registrations#thanks"
    get "users/confirmation/complete", to: "users/confirmations#complete"
    get "profile/edit", to: "users/confirmations#edit"
    patch "profile", to: "users/confirmations#update"
  end
  
  namespace :e_sal, :path => "e-sal" do
     get '/' => 'homes#index'
  end
  
end
