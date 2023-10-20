class FoodRecipesController < ApplicationController
    before_action :authenticate_user!, only: [:destroy]
    before_action :foods_by_recipe, except: [:index, :general_shopping_list]
  
    def index
      @recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)
    end
  
    def new
      @food_recipe = @recipe.food_recipes.new
    end
  
    def create
      food_recipe = @recipe.food_recipes.new(food_recipe_params)
      if food_recipe.save
        flash[:notice] = 'The ingredient was added successfully!'
        redirect_to recipe_path(@recipe)
      else
        flash[:alert] = food_recipe.errors.full_messages.join(', ')
        redirect_to request.referrer
      end
    end
  
    def edit
      @food_recipe = @recipe.food_recipes.find_by(id: params[:id])
    end
  
    def update
      food_recipe = @recipe.food_recipes.find_by(id: params[:id])
  
      if food_recipe.update(food_recipe_params)
        flash[:notice] = 'The ingredient was modified successfully!'
        redirect_to recipe_path(@recipe)
      else
        flash[:alert] = food_recipe.errors.full_messages.join(', ')
        redirect_to request.referrer
      end
    end
  
    def destroy
      food_recipe = FoodRecipe.find(params[:id])
      recipe = food_recipe.recipe
      if food_recipe.destroy
        flash[:notice] = 'The Food was removed successfully!'
      else
        flash[:alert] = 'The Food was not removed!'
      end
      redirect_to recipe_path(recipe)
    end
  
    def general_shopping_list
        # Fetch the general foods that belong to the user.
        @general_foods = current_user.foods
      
        @foods = []
        # Save only the ingredients that are missing (more than you have).
        @general_foods.each do |food|
          @foods << food if food.general_food_quantity > food.quantity
        end
      
        # Find the total price.
        @total_general_price = @foods.sum(&:general_price)
      end      
  
    private
  
    def food_recipe_params
      params.require(:food_recipe).permit(:food_id, :quantity)
    end
  
    def foods_by_recipe
      @foods = current_user.foods.all
      @recipe = Recipe.find_by(id: params[:recipe_id])
      @food_recipe = @recipe.food_recipes
      # Select the foods that are not in the recipe.
      @foods_not_in_recipe = @foods.where.not(id: @food_recipe.pluck(:food_id))
    end
  end  