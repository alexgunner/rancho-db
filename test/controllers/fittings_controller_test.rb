require 'test_helper'

class FittingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fitting = fittings(:one)
  end

  test "should get index" do
    get fittings_url
    assert_response :success
  end

  test "should get new" do
    get new_fitting_url
    assert_response :success
  end

  test "should create fitting" do
    assert_difference('Fitting.count') do
      post fittings_url, params: { fitting: { cost: @fitting.cost, description: @fitting.description, name: @fitting.name } }
    end

    assert_redirected_to fitting_url(Fitting.last)
  end

  test "should show fitting" do
    get fitting_url(@fitting)
    assert_response :success
  end

  test "should get edit" do
    get edit_fitting_url(@fitting)
    assert_response :success
  end

  test "should update fitting" do
    patch fitting_url(@fitting), params: { fitting: { cost: @fitting.cost, description: @fitting.description, name: @fitting.name } }
    assert_redirected_to fitting_url(@fitting)
  end

  test "should destroy fitting" do
    assert_difference('Fitting.count', -1) do
      delete fitting_url(@fitting)
    end

    assert_redirected_to fittings_url
  end
end
