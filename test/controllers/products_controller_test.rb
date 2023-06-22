# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a product' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select 'h2', products(:ps4).title
    assert_select '.title', 'PS4 em bom estado'
    assert_select '.price', '358.92'
  end

  test 'render new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'create a new product' do
    assert_difference 'Product.count' do
      post products_path, params: {
        product: {
          title: 'Xbox One',
          description: 'Xbox One em bom estado',
          price: 358.92
        }
      }
    end
    assert_redirected_to products_path
  end

  test 'does not allow to create a new product with' do
    post products_path, params: {
      product: {
        title: '',
        description: '',
        price: 358.92
      }
    }
    assert_response :unprocessable_entity
  end
end
