require 'test_helper'

class Admin::CurrentPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_current_passwords_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_current_passwords_create_url
    assert_response :success
  end

end
