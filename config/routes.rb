Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'


  get '/foods', to: 'foods#index'
  get '/foods/new', to: 'foods#new', as: 'new_food'
  resources :foods, only: [:create,:destroy]

  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    patch 'update_status', on: :member
    resources :food_recipes, only: [:new, :create, :edit, :update, :destroy]
  end
  
  
  get '/public', to: 'recipes#new'
  resources :inventories, only: [:index, :show, :new, :edit,  :update, :create, :destroy]

  # Route for the 'General shopping list' page handled by FoodRecipesController
  get '/general_shopping_list', to: 'general_shopping_list#shopping_list', as: 'general_shopping_list'

  
end
