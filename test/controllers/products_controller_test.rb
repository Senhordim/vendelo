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
end
