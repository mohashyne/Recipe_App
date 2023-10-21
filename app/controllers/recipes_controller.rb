class RecipesController < ApplicationController
  #     # Devise for authentication
  before_action :authenticate_user!

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
    @inventories = @recipe.inventories
    # @recipe = Recipe.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    # redirect_to recipes_path, alert: 'Recipe not found.'
    @recipe = Recipe.includes(:food_recipes).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path, alert: 'Recipe not found.'
    @inventories = Inventory.all
  end

  def update_status
    @recipe = Recipe.find(params[:id])
    if @recipe.update(public: params[:public])
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: @recipe.errors.full_messages.join(', ') }, status: 400
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, Notice: 'Recipes added successfully'
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = "Recipe removed successfully."
    else
      flash[:error] = "Error removing the recipe."
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
