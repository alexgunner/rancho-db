require 'test_helper'

class CombosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @combo = combos(:one)
  end

  test "should get index" do
    get combos_url
    assert_response :success
  end

  test "should get new" do
    get new_combo_url
    assert_response :success
  end

  test "should create combo" do
    assert_difference('Combo.count') do
      post combos_url, params: { combo: { branch_id: @combo.branch_id, description: @combo.description, name: @combo.name, sale_cost: @combo.sale_cost } }
    end

    assert_redirected_to combo_url(Combo.last)
  end

  test "should show combo" do
    get combo_url(@combo)
    assert_response :success
  end

  test "should get edit" do
    get edit_combo_url(@combo)
    assert_response :success
  end

  test "should update combo" do
    patch combo_url(@combo), params: { combo: { branch_id: @combo.branch_id, description: @combo.description, name: @combo.name, sale_cost: @combo.sale_cost } }
    assert_redirected_to combo_url(@combo)
  end

  test "should destroy combo" do
    assert_difference('Combo.count', -1) do
      delete combo_url(@combo)
    end

    assert_redirected_to combos_url
  end
end
