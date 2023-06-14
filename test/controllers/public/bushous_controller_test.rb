require "test_helper"

class Public::BushousControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_bushous_index_url
    assert_response :success
  end

  test "should get show" do
    get public_bushous_show_url
    assert_response :success
  end
end
