Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  get '/foods', to: 'foods#index'
  
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'

  get '/inventories/:id', to: 'inventories#index', as: 'inventories'

  
  resources :inventories, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show] do
    patch 'update_status', on: :member
  end

end
