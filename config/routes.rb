Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'


  get '/foods', to: 'foods#index'
  # get '/inventories/:id', to: 'inventories#index', as: 'inventories'
  # get '/inventories', to: 'inventories#index', as: 'inventories'

  resources :recipes, only: [:index, :show] do
    patch 'update_status', on: :member
  end


  get '/public', to: 'recipes#public'


  # resources :inventories, only: [:index, :new, :create, :destroy]
  resources :inventories, only: [:index, :new, :create, :destroy] 
end
