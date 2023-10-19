class AddUnitToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :unit, :string
  end
end
