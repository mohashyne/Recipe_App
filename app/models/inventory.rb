class Inventory < ApplicationRecord
  validates :food, presence: true 

  belongs_to :user
  belongs_to :food
end
