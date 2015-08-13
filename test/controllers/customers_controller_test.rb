require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { classification: @customer.classification, date_of_birth: @customer.date_of_birth, email: @customer.email, employment_basis: @customer.employment_basis, first_name: @customer.first_name, gender: @customer.gender, home_address: @customer.home_address, is_supervisor: @customer.is_supervisor, last_name: @customer.last_name, mobile_number: @customer.mobile_number, pay_adjustment: @customer.pay_adjustment, preferred_name: @customer.preferred_name, xeroemployeeid: @customer.xeroemployeeid }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer, customer: { classification: @customer.classification, date_of_birth: @customer.date_of_birth, email: @customer.email, employment_basis: @customer.employment_basis, first_name: @customer.first_name, gender: @customer.gender, home_address: @customer.home_address, is_supervisor: @customer.is_supervisor, last_name: @customer.last_name, mobile_number: @customer.mobile_number, pay_adjustment: @customer.pay_adjustment, preferred_name: @customer.preferred_name, xeroemployeeid: @customer.xeroemployeeid }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer
    end

    assert_redirected_to customers_path
  end
end
