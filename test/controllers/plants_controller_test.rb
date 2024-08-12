require "test_helper"

class PlantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plants_index_url
    assert_response :success
  end

  test "should get show" do
    get plants_show_url
    assert_response :success
  end

  test "should get new" do
    get plants_new_url
    assert_response :success
  end

  test "should get create" do
    get plants_create_url
    assert_response :success
  end

  test "should get edit" do
    get plants_edit_url
    assert_response :success
  end

  test "should get update" do
    get plants_update_url
    assert_response :success
  end

  test "should get destroy" do
    get plants_destroy_url
    assert_response :success
  end
end
