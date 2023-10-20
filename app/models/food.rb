class Food < ApplicationRecord
    has_many :food_recipes
  has_many :recipes, through: :food_recipes
    def name_with_measurement_unit
        "#{name} (#{measurement_unit})"
      end

      def general_food_quantity
        food_recipes.joins(:food).sum('food_recipes.quantity')
      end
    
      def total_food
        (general_food_quantity - quantity).abs
      end
    
      # Method to calculate the total price of an ingredient.
      def general_price
        total_food * price
      end
end
