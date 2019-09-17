require 'test_helper'

class DosificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dosification = dosifications(:one)
  end

  test "should get index" do
    get dosifications_url
    assert_response :success
  end

  test "should get new" do
    get new_dosification_url
    assert_response :success
  end

  test "should create dosification" do
    assert_difference('Dosification.count') do
      post dosifications_url, params: { dosification: { activity: @dosification.activity, authorization_number: @dosification.authorization_number, branch_id: @dosification.branch_id, dosification_key: @dosification.dosification_key, valid_until: @dosification.valid_until } }
    end

    assert_redirected_to dosification_url(Dosification.last)
  end

  test "should show dosification" do
    get dosification_url(@dosification)
    assert_response :success
  end

  test "should get edit" do
    get edit_dosification_url(@dosification)
    assert_response :success
  end

  test "should update dosification" do
    patch dosification_url(@dosification), params: { dosification: { activity: @dosification.activity, authorization_number: @dosification.authorization_number, branch_id: @dosification.branch_id, dosification_key: @dosification.dosification_key, valid_until: @dosification.valid_until } }
    assert_redirected_to dosification_url(@dosification)
  end

  test "should destroy dosification" do
    assert_difference('Dosification.count', -1) do
      delete dosification_url(@dosification)
    end

    assert_redirected_to dosifications_url
  end
end
