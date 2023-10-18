class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inventories = current_user.inventories
    @total_price = 0

    @inventories.each do |inventory|
      food = Food.find(inventory.food_id)
      @total_price += food.price * inventory.quantity
    end
  end
end
