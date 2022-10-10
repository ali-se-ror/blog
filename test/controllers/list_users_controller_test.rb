require "test_helper"

class ListUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list_user = list_users(:one)
  end

  test "should get index" do
    get list_users_url, as: :json
    assert_response :success
  end

  test "should create list_user" do
    assert_difference('ListUser.count') do
      post list_users_url, params: { list_user: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show list_user" do
    get list_user_url(@list_user), as: :json
    assert_response :success
  end

  test "should update list_user" do
    patch list_user_url(@list_user), params: { list_user: {  } }, as: :json
    assert_response 200
  end

  test "should destroy list_user" do
    assert_difference('ListUser.count', -1) do
      delete list_user_url(@list_user), as: :json
    end

    assert_response 204
  end
end
