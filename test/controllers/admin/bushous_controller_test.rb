require "test_helper"

class Admin::BushousControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bushous_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_bushous_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_bushous_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_bushous_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_bushous_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_bushous_update_url
    assert_response :success
  end
end
