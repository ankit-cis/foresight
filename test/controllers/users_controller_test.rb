require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { address_1: @user.address_1, address_2: @user.address_2, county: @user.county, email: @user.email, forename: @user.forename, insurer: @user.insurer, is_admin: @user.is_admin, password_digest: @user.password_digest, postcode: @user.postcode, surname: @user.surname, telephone_number: @user.telephone_number, title_id: @user.title_id, town: @user.town } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { address_1: @user.address_1, address_2: @user.address_2, county: @user.county, email: @user.email, forename: @user.forename, insurer: @user.insurer, is_admin: @user.is_admin, password_digest: @user.password_digest, postcode: @user.postcode, surname: @user.surname, telephone_number: @user.telephone_number, title_id: @user.title_id, town: @user.town } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
