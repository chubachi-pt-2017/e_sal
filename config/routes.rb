Rails.application.routes.draw do

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
    get '/programming/:id', to: 'programmings#show', as: :programming_detail
    get '/programming', to: 'programmings#index'
    # get 'tutorial/:id', to: 'tutorials#show' 
    # get 'tutorial', to: 'tutorials#index'

    resources :tutorials do
      collection do
        get '/list', to: 'tutorials#list'
        post '/photos', to: 'photos#create'
        post '/:id/edit/photos', to: 'photos#create'
      end
    end

    resources :original_categories
    resources :photos
  end

  get "/agreement", to: "home#agreement", as: :agreement
  root 'home#index'
end
