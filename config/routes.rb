Rails.application.routes.draw do

  # Defines the root path route ("/")
    post '/login', to: 'sessions#create'
     delete '/logout', to: 'sessions#destroy'

    resources :users, only: [:show]
    get '/users/:id', to: 'users#show'

    get '/user_posts', to: 'posts#user_posts'

  resources :users, only: [:index, :create, :show]
  resources :posts
  
end
