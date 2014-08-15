require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get who" do
    get :who
    assert_response :success
  end

  test "should get bio" do
    get :bio
    assert_response :success
  end

  test "should get events" do
    get :events
    assert_response :success
  end

  test "should get playlists" do
    get :playlists
    assert_response :success
  end

end
