require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get betray" do
    get public_users_betray_url
    assert_response :success
  end

  test "should get unsubscribed" do
    get public_users_unsubscribed_url
    assert_response :success
  end
end
