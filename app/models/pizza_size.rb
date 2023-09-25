class PizzaSize < ApplicationRecord
  has_many :pizza_size_toppings
  has_many :toppings, through: :pizza_size_toppings
end
