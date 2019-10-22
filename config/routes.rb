Rails.application.routes.draw do
  post '/login', to: 'auth#create'
  resources :matches
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users, only: [:index, :create]
  get '/profile/:id', to:'users#profile'
  get '/chat/:id', to: 'chats#get_chat'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
