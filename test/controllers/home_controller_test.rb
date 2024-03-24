require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should redirect to login when not authenticated for admin" do
    get admin_path
    assert_redirected_to new_user_session_path
  end
  
  test "should get admin when authenticated" do
    user = User.create(email: "foo@bar.bazz", password: "password")
    sign_in user
    get admin_path
    assert_response :success
  end
end
