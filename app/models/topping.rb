class Topping < ApplicationRecord
  has_many :pizza_size_toppings
  has_many :pizza_sizes, through: :pizza_size_toppings
end