require "test_helper"

class V1::UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(email: "test@example.com") # Create a sample user for tests
  end

  test "should get index" do
    get v1_users_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal User.all.count, json_response["users"].count
    assert_equal @user.email, json_response["users"][0]['email']
  end

  test "should show user" do
    get v1_user_url(@user)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @user.email, json_response["user"]["email"]
  end

  test "should create user" do
    assert_difference("User.count") do
      post v1_users_url, params: { users: { email: "newuser@example.com" } }
    end

    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal "user created", json_response["message"]
    assert_equal 'newuser@example.com', json_response["user"]["email"]
  end

  test "should return error for invalid user creation" do
    assert_no_difference("User.count") do
      post v1_users_url, params: { users: { email: "" } } # Empty email is invalid
    end
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response["error"], "Email can't be blank"
  end

  test "should update user" do
    patch v1_user_url(@user), params: { users: { email: "updated@example.com" } }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "User updated", json_response["message"]
    assert_equal "updated@example.com", json_response["user"]["email"]
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete v1_user_url(@user)
    end
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "user deleted", json_response["message"]
  end
end
