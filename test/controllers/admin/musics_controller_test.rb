require "test_helper"

class Admin::MusicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_musics_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_musics_show_url
    assert_response :success
  end
end
