class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
