require 'test_helper'

class AccidentStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accident_status = accident_statuses(:one)
  end

  test "should get index" do
    get accident_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_accident_status_url
    assert_response :success
  end

  test "should create accident_status" do
    assert_difference('AccidentStatus.count') do
      post accident_statuses_url, params: { accident_status: { description: @accident_status.description, name: @accident_status.name, status_const: @accident_status.status_const } }
    end

    assert_redirected_to accident_status_url(AccidentStatus.last)
  end

  test "should show accident_status" do
    get accident_status_url(@accident_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_accident_status_url(@accident_status)
    assert_response :success
  end

  test "should update accident_status" do
    patch accident_status_url(@accident_status), params: { accident_status: { description: @accident_status.description, name: @accident_status.name, status_const: @accident_status.status_const } }
    assert_redirected_to accident_status_url(@accident_status)
  end

  test "should destroy accident_status" do
    assert_difference('AccidentStatus.count', -1) do
      delete accident_status_url(@accident_status)
    end

    assert_redirected_to accident_statuses_url
  end
end
