Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :matches
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users
  get '/profile', to:'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
