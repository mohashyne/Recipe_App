class Inventory < ApplicationRecord
  validates :food, presence: true

  belongs_to :user
  belongs_to :food
  belongs_to :recipe
end
