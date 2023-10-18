Rails.application.routes.draw do
  devise_for :users

  get '/foods', to: 'foods#index'
  
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  resources :recipes, only: [:index, :show] do
    patch 'update_status', on: :member
  end

end
