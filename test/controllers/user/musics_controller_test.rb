require "test_helper"

class User::MusicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_musics_index_url
    assert_response :success
  end

  test "should get new" do
    get user_musics_new_url
    assert_response :success
  end

  test "should get show" do
    get user_musics_show_url
    assert_response :success
  end
end
