class PizzaOrdersController < ApplicationController
  # POST /pizza_orders
  def create
    result = PizzaOrderService.new(params[:orders]).call
    render json: { voucher: result }
  end
end
