require 'test_helper'

class PizzaOrdersControllerTest < ActionDispatch::IntegrationTest
  fixtures :pizza_sizes, :toppings

  test 'single pizza order with multiple toppings' do
    post '/pizza_orders', params: {
      orders: [
        { pizza_size_id: pizza_sizes(:medium).id, topping_ids: [toppings(:pepperoni_medium).id,toppings(:extra_cheese).id] },
      ]
    }, as: :json

    body = JSON.parse(response.body)

    assert_equal true, body['voucher']['success']
    assert_equal 1, body['voucher']['item_detail'].size
    assert_equal '33.0', body['voucher']['total_amount']
  end

  test 'multiple pizza order with single topping' do
    post '/pizza_orders', params: {
      orders: [
        { pizza_size_id: pizza_sizes(:small).id, topping_ids: [toppings(:pepperoni_small).id] },
        { pizza_size_id: pizza_sizes(:medium).id, topping_ids: [toppings(:pepperoni_medium).id] },
        { pizza_size_id: pizza_sizes(:large).id, topping_ids: [toppings(:extra_cheese).id] },
      ]
    }, as: :json

    body = JSON.parse(response.body)

    assert_equal true, body['voucher']['success']
    assert_equal 3, body['voucher']['item_detail'].size
    assert_equal '81.0', body['voucher']['total_amount']
  end

  test 'create pizza order with invalid topping' do
    post '/pizza_orders', params: {
      orders: [
        { pizza_size_id: pizza_sizes(:small).id, topping_ids: [999] }, # Invalid topping ID
      ]
    }, as: :json

    body = JSON.parse(response.body)

    assert_equal false, body['voucher']['success']
    assert_equal "Couldn't find Topping with 'id'=999", body['voucher']['message']
  end

  test 'create pizza order with incompatible toppings' do
    post '/pizza_orders', params: {
      orders: [
        { pizza_size_id: pizza_sizes(:large).id, topping_ids: [toppings(:pepperoni_medium).id] }, # Incompatible topping for large pizza
      ]
    }, as: :json

    body = JSON.parse(response.body)

    assert_equal false, body['voucher']['success']
    assert_equal 'Selected toppings are not compatible with the chosen pizza size', body['voucher']['message']
  end
end
