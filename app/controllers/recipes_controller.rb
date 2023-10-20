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
    # @recipe = Recipe.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    # redirect_to recipes_path, alert: 'Recipe not found.'
    @recipe = Recipe.includes(:food_recipes).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path, alert: 'Recipe not found.'
  end

  def public
    @public_recipes = Recipe.where(public: true)
  end

  def update_status
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:public]) if params[:public].present?
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new
    if @recipe.save
      redirect_to @recipes, notice: "#{recipe.name}:  Recipe sucessfully created!"
    else
      render :new
    end
  end

end
