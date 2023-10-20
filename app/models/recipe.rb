class Recipe < ApplicationRecord
  def self.ispublic
    where(is_public: true).order(created_at: :desc)
  end
  belongs_to :user
  has_and_belongs_to_many :foods, join_table: 'recipe_foods'
  has_many :food_recipes, dependent: :destroy

  # Validations.
  validates :name, :description, presence: true
  validates :name, length: { maximum: 250 }
  validates :preparation_time, :cooking_time, presence: true, comparison: { greater_than_or_equal_to: 0 },
                                              numericality: { only_integer: true }
  validates :public, inclusion: { in: [true, false] }

  def total_price
    food_recipes.includes(:food).sum { |recipe_food| food_recipe.food.price * food_recipe.quantity }
  end

  def count_ingredients
    foods.count
  end

  def convert_hours_to_minutes
    self.preparation_time = (preparation_time.to_f * 60).to_i
    self.cooking_time = (cooking_time.to_f * 60).to_i
  end
end
