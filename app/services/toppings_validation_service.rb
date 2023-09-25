class ToppingsValidationService
  # Initializes the service with pizza size and toppings.
  def initialize(pizza_size, toppings)
    @pizza_size = pizza_size
    @toppings = toppings
  end

  # Validates if the selected toppings are compatible with the chosen pizza size.
  def call
    # Get a list of compatible toppings for the pizza size
    compatible_toppings = compatible_toppings_for_pizza_size

    # Check if all selected toppings are included in the list of compatible toppings
    @toppings.all? { |topping| compatible_toppings.include?(topping.id) }
  end

  private

  # Retrieves a list of compatible toppings for the chosen pizza size.
  def compatible_toppings_for_pizza_size
    @pizza_size.toppings.pluck(:id)
  end
end
