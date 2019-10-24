Rails.application.routes.draw do
  post '/login', to: 'auth#create'
  resources :matches, only: [:create, :show]
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users
  get '/profile/:id', to:'users#profile'
  get '/chat/:id', to: 'chats#get_chat'
  delete '/matches', to: 'matches#delete'
end
