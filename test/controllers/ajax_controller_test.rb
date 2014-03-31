require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get get_pizza_details" do
    get :get_pizza_details
    assert_response :success
  end

end
