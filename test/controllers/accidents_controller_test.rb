require 'test_helper'

class AccidentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accident = accidents(:one)
  end

  test "should get index" do
    get accidents_url
    assert_response :success
  end

  test "should get new" do
    get new_accident_url
    assert_response :success
  end

  test "should create accident" do
    assert_difference('Accident.count') do
      post accidents_url, params: { accident: { accident_status_id: @accident.accident_status_id, company_id: @accident.company_id, lat: @accident.lat, long: @accident.long, user_id: @accident.user_id, video_id: @accident.video_id } }
    end

    assert_redirected_to accident_url(Accident.last)
  end

  test "should show accident" do
    get accident_url(@accident)
    assert_response :success
  end

  test "should get edit" do
    get edit_accident_url(@accident)
    assert_response :success
  end

  test "should update accident" do
    patch accident_url(@accident), params: { accident: { accident_status_id: @accident.accident_status_id, company_id: @accident.company_id, lat: @accident.lat, long: @accident.long, user_id: @accident.user_id, video_id: @accident.video_id } }
    assert_redirected_to accident_url(@accident)
  end

  test "should destroy accident" do
    assert_difference('Accident.count', -1) do
      delete accident_url(@accident)
    end

    assert_redirected_to accidents_url
  end
end
