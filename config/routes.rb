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

    resources :programmings, path: "programming" do
      resources :programming_answers, path: "answer", except: [:index, :destroy] do
        collection do
          get '/list', to: 'programming_answers#list'
          get '/submit', to: 'programming_answers#submit'
        end
      end
    end

    resources :tutorials do
      collection do
        get '/list', to: 'tutorials#list'
        get '/list/:main_category' => 'tutorials#main_category_list'
        get '/list/:main_category/:original_category' => 'tutorials#original_category_list'
        post '/photos', to: 'photos#create'
        post '/:id/edit/photos', to: 'photos#create'
        post '/preview/:id' => 'tutorials#preview'
        patch '/preview/:id' => 'tutorials#preview'
        get '/preview/:id' => 'tutorials#preview'
        post '/tutorial-like' => 'tutorial_likes#create'
        delete '/tutorial-like' => 'tutorial_likes#destroy'
        post '/tutorial-dislike' => 'tutorial_dislikes#create'
        delete '/tutorial-dislike' => 'tutorial_dislikes#destroy'
      end
      resources :comments
    end

    resources :original_categories
    resources :photos
  end

  get "/agreement", to: "home#agreement", as: :agreement
  root 'home#index'
  # どれにもroutingされなければ、404を表示する(なので下記のroutingより下には何も書いてはいけない)
  get '*path', controller: 'application', action: 'render_404'
end
