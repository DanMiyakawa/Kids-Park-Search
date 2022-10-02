require "test_helper"

class Public::ParksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_parks_index_url
    assert_response :success
  end

  test "should get show" do
    get public_parks_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_parks_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_parks_new_url
    assert_response :success
  end
end
