class RecipesController < ApplicationController
  #     # Devise for authentication
  #     before_action :authenticate_user!

  # # association between User and Recipe models
  #   def index
  #     @recipes = current_user.recipes
  #   end
  def index
    @inventories = current_user.inventories
  end

  def index
    @recipes = Recipe.ispublic
  end

  def show
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path, alert: 'Recipe not found.'
  end
end
