require 'test_helper'

class V1::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = Organization.create(name: "test-org")
    @user = User.create(email: 'hinthalapudiharish@gmail.com', organization: @organization)
    @profile = Profile.create(first_name: 'harish', last_name: 'chinthalapudi', phone_number: '9182400789', user: @user)
  end

  test 'should show profile for existing user' do
    get v1_user_profile_url(@user)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @profile.id, json_response['profile']['id']
  end

  test 'should create a new profile for a user' do
    @user.profile.destroy if @user.profile

    post v1_user_profile_url(@user), params: {
      profile: {
        first_name: 'Jane',
        last_name: 'Smith',
        phone_number: '9876543210'
      }
    }
    assert_response :created
    assert_equal 'Jane', JSON.parse(response.body)['first_name']
  end

  test 'should update an existing profile for a user' do
    @user.profile.destroy if @user.profile

    @user.create_profile(first_name: 'yamuna', last_name: 'kunam', phone_number: '9875424509')

    patch v1_user_profile_url(@user), params: {
      profile: {
        first_name: 'Sravani',
        last_name: 'Soudhi',
        phone_number: '9876543210'
      }
    }
    assert_response :success

    updated_profile = JSON.parse(response.body)['profile']
    assert_equal 'Sravani', updated_profile['first_name']
    assert_equal 'Soudhi', updated_profile['last_name']
    assert_equal '9876543210', updated_profile['phone_number']
  end
end
