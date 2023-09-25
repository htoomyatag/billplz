# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create pizza sizes
small = PizzaSize.create(name: 'Small', base_price: 15.0)
medium = PizzaSize.create(name: 'Medium', base_price: 22.0)
large = PizzaSize.create(name: 'Large', base_price: 30.0)

# Create toppings
pepperoni_small = Topping.create(name: 'Pepperoni for Small Pizza', price: 3.0)
pepperoni_medium = Topping.create(name: 'Pepperoni for Medium Pizza', price: 5.0)
extra_cheese = Topping.create(name: 'Extra Cheese', price: 6.0)

# Define compatible toppings for pizza sizes
small.toppings << pepperoni_small
small.toppings << extra_cheese

medium.toppings << pepperoni_medium
medium.toppings << extra_cheese

large.toppings << extra_cheese
