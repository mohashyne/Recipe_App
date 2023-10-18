class AddPublicToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :is_public, :boolean, default: true
  end
end
