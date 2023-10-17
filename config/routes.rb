Rails.application.routes.draw do
  devise_for :users
  
  get '/foods', to: 'foods#index'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  get '/recipes', to: 'recipes#index'
end
