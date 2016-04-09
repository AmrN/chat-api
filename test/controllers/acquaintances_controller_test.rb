require 'test_helper'

class AcquaintancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acquaintance = acquaintances(:one)
  end

  test "should get index" do
    get acquaintances_url
    assert_response :success
  end

  test "should create acquaintance" do
    assert_difference('Acquaintance.count') do
      post acquaintances_url, params: { acquaintance: {  } }
    end

    assert_response 201
  end

  test "should show acquaintance" do
    get acquaintance_url(@acquaintance)
    assert_response :success
  end

  test "should update acquaintance" do
    patch acquaintance_url(@acquaintance), params: { acquaintance: {  } }
    assert_response 200
  end

  test "should destroy acquaintance" do
    assert_difference('Acquaintance.count', -1) do
      delete acquaintance_url(@acquaintance)
    end

    assert_response 204
  end
end
