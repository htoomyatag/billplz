class PizzaSizeTopping < ApplicationRecord
  belongs_to :pizza_size
  belongs_to :topping
end
