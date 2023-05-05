require "test_helper"

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_users_index_url
    assert_response :success
  end

  test "should get show" do
    get user_users_show_url
    assert_response :success
  end

  test "should get followings" do
    get user_users_followings_url
    assert_response :success
  end

  test "should get followers" do
    get user_users_followers_url
    assert_response :success
  end
end
