class GeneralShoppingListController < ApplicationController
  def shopping_list
    @total_value = 0
    foods = Food.all.includes(:food_recipes).order(created_at: :desc)

    foods.each do |food|
      food.update_quantity
      @total_value += food.quantity.to_f * food.price.to_f
    end

    @foods = Food.where('quantity != 0')
    @selected_recipe = Recipe.find(params[:recipe_id])
    @selected_inventory = Inventory.find(params[:inventory_id])

    recipe_foods = @selected_recipe.foods
    inventory_foods = [@selected_inventory.food]

    # Determine which foods are missing
    @foods_to_purchase = recipe_foods - inventory_foods

    render 'food_recipes/general_shopping_list'
  end
end
