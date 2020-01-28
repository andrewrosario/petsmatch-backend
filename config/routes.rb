Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
  post "/graphql", to: "graphql#execute"
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
