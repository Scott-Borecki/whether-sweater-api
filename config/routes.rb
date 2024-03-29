Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :backgrounds, only: [:index]
      resources :forecast, only: [:index]
      resources :road_trip, only: [:index]
      resources :sessions, only: [:create]
      resources :users, only: [:create]

      get '/book-search', to: 'book_search#index'
    end
  end
end
