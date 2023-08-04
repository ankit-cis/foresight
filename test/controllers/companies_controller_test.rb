require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post companies_url, params: { company: { address_1: @company.address_1, address_2: @company.address_2, app_licenses: @company.app_licenses, company_type_id: @company.company_type_id, county: @company.county, name: @company.name, payment_type_id: @company.payment_type_id, postcode: @company.postcode, telephone_number: @company.telephone_number, town: @company.town } }
    end

    assert_redirected_to company_url(Company.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { address_1: @company.address_1, address_2: @company.address_2, app_licenses: @company.app_licenses, company_type_id: @company.company_type_id, county: @company.county, name: @company.name, payment_type_id: @company.payment_type_id, postcode: @company.postcode, telephone_number: @company.telephone_number, town: @company.town } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end
end
