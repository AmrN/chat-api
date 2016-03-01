require 'test_helper'

class ChatroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chatroom = chatrooms(:one)
  end

  test "should get index" do
    get chatrooms_url
    assert_response :success
  end

  test "should create chatroom" do
    assert_difference('Chatroom.count') do
      post chatrooms_url, params: { chatroom: {  } }
    end

    assert_response 201
  end

  test "should show chatroom" do
    get chatroom_url(@chatroom)
    assert_response :success
  end

  test "should update chatroom" do
    patch chatroom_url(@chatroom), params: { chatroom: {  } }
    assert_response 200
  end

  test "should destroy chatroom" do
    assert_difference('Chatroom.count', -1) do
      delete chatroom_url(@chatroom)
    end

    assert_response 204
  end
end
