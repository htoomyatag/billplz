class PizzaOrderService
  # Initializes the PizzaOrderService with a list of orders.
  # 
  # @param orders [Array<Hash>] A list of orders, where each order is a Hash containing
  #   the pizza_size_id and topping_ids for a pizza order.
  #   Example: [{ pizza_size_id: 1, topping_ids: [1, 3] }, { pizza_size_id: 2, topping_ids: [2, 3] }]
  def initialize(orders)
    @orders = orders
    @item_details = []
    @total_amount = 0
  end

  def call
    @orders.each do |order|
      pizza_size_id = order['pizza_size_id']
      topping_ids = order['topping_ids']

      begin
        # Find the selected pizza size
        pizza_size = PizzaSize.find(pizza_size_id)
        # Find the selected toppings
        toppings = Topping.find(topping_ids)
      rescue ActiveRecord::RecordNotFound => e
        return error_response(e.message)
      end

      # Create a ToppingsValidationService instance to perform toppings validation
      toppings_validation_service = ToppingsValidationService.new(pizza_size, toppings).call

      # Check if selected toppings are compatible with the chosen pizza size
      unless toppings_validation_service
        return error_response('Selected toppings are not compatible with the chosen pizza size')
      end

      amount = pizza_size.base_price + toppings.sum(&:price)

      # Create item details based on user's choices
      generate_item_details(pizza_size, toppings, amount)
    end

    result = success_response
    return result
  end

  private

  def success_response
    {
      item_detail: @item_details,
      total_amount: @total_amount,
      success: true
    }
  end

  def error_response(error_message)
    {
      success: false,
      message: error_message
    }
  end

  def generate_item_details(pizza_size, toppings, amount)
   
    @total_amount = @total_amount + amount

    @item_details << {
      item_id: pizza_size.id,
      topping_ids: toppings.map(&:id),
      amount: amount
    }
    @item_details
  end
end
