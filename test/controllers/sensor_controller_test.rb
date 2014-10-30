require 'test_helper'

class SensorControllerTest < ActionController::TestCase
  test "should get post" do
    get :post
    assert_response :success
  end

end
