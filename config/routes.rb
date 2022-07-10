Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#create'
      post '/signup', to: 'users#create'
      resources :posts, only: [:create, :index] do
        resources :comments, only: [:create]
      end
    end
  end
end
