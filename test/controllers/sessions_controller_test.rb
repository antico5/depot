require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
  end

  test "should get login form" do
    get login_url
    assert_response :success
  end

  test "should log user in with correct name and password" do
    post_on_login
    assert_equal session[:user_id], @user.id
    assert_redirected_to admin_index_url
  end

  test "should log user out" do
    post_on_login
    delete logout_url
    assert_nil session[:user_id]
    assert_redirected_to store_index_url
  end

  def post_on_login
    post login_url, params: { name: @user.name, password: 'secret' }
  end

end
