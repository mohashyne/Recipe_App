class RecipesController < ApplicationController
  #     # Devise for authentication
  before_action :authenticate_user!

  #   TODO:
  # # association between User and Recipe models
  #   def index
  #     @recipes = current_user.recipes
  #   end

  #   TODO:
  #   def index
  #     @inventories = current_user.inventories
  #   end

  def index
    @recipes = current_user.recipes
    @missing_ingredients = {}

    @recipes.each do |recipe|
      missing_for_this_recipe = []

      recipe.food_recipes.each do |food_recipe|
        missing_for_this_recipe << food_recipe.food unless current_user.foods.include?(food_recipe.food)
      end

      @missing_ingredients[recipe.id] = missing_for_this_recipe unless missing_for_this_recipe.empty?
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path, alert: 'Recipe not found.'
  end
end
