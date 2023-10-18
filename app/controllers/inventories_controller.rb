class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inventories = current_user.inventories
  end
end

