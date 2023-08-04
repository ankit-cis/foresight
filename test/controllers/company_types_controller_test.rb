require 'test_helper'

class CompanyTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_type = company_types(:one)
  end

  test "should get index" do
    get company_types_url
    assert_response :success
  end

  test "should get new" do
    get new_company_type_url
    assert_response :success
  end

  test "should create company_type" do
    assert_difference('CompanyType.count') do
      post company_types_url, params: { company_type: { description: @company_type.description, name: @company_type.name } }
    end

    assert_redirected_to company_type_url(CompanyType.last)
  end

  test "should show company_type" do
    get company_type_url(@company_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_type_url(@company_type)
    assert_response :success
  end

  test "should update company_type" do
    patch company_type_url(@company_type), params: { company_type: { description: @company_type.description, name: @company_type.name } }
    assert_redirected_to company_type_url(@company_type)
  end

  test "should destroy company_type" do
    assert_difference('CompanyType.count', -1) do
      delete company_type_url(@company_type)
    end

    assert_redirected_to company_types_url
  end
end
