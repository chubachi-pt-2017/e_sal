Rails.application.routes.draw do
  
  namespace :e_sal do
    get 'tutorials/index'
  end

  root 'home#index'
  
  get "/agreement", to: "home#agreement", as: :agreement

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
    patch "profile/edit", to: "users/confirmations#update"
  end
  
  namespace :e_sal, :path => "e-sal" do
    get '/', to: 'homes#index'
    # get 'tutorial/:id', to: 'tutorials#show' 
    # get 'tutorial', to: 'tutorials#index'

    resources :tutorials do
      collection do
        # get 'list/:id', to: 'tutorials#list'
        get 'list/:user_name', to: 'tutorials#list'        
      end
    end

  end
  
end
