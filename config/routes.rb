Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :users, only: [:show]

  get '/users/:user_id/items', to: 'users#items'
  get '/users/:user_id/items/:id', to: 'users#item_show'
  post '/users/:user_id/items', to: 'users#create'

end
