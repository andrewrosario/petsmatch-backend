Rails.application.routes.draw do
  resources :matches
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
