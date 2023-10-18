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

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = current_user.inventories.build(inventory_params)
    if @inventory.save
      redirect_to inventories_path, notice: 'Food added to inventory.'
    else
      render :new
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:food_id, :quantity)
  end
end
