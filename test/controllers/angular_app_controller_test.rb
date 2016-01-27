require 'test_helper'

class AngularAppControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get angular_app_index_url
    assert_response :success
  end

end
