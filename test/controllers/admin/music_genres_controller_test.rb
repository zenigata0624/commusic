require "test_helper"

class Admin::MusicGenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_music_genres_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_music_genres_edit_url
    assert_response :success
  end
end
