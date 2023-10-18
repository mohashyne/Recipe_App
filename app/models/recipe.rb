class Recipe < ApplicationRecord
  def self.ispublic
    where(is_public: true).order(created_at: :desc)
  end

  belongs_to :user
  has_many :food_recipes
end
