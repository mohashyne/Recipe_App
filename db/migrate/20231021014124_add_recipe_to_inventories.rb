class AddRecipeToInventories < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :recipe, foreign_key: true, default: 1
  end
  
end
