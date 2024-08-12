require "test_helper"

class RentingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get rentings_create_url
    assert_response :success
  end
end
