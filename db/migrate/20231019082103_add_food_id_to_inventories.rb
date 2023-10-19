class AddFoodIdToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :food_id, :integer
  end
end
