Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  get '/foods', to: 'foods#index'
  get '/inventories/:id', to: 'inventories#index', as: 'inventories'

  resources :recipes, only: [:index, :show] do
    patch 'update_status', on: :member
  end

  get '/public', to: 'recipes#public'


  resources :inventories, only: [:index, :new, :create, :destroy]
end
