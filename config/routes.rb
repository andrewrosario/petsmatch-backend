Rails.application.routes.draw do
  post '/login', to: 'auth#create'
  resources :matches
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users, only: [:index, :create]
  get '/profile', to:'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
