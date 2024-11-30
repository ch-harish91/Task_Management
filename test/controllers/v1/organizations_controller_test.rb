require 'test_helper'

class V1::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = Organization.create(name: 'Test Org', code: 'ORG001', status: 'boolean')
  end

  test 'should get index' do
    get v1_organizations_url
    assert_response :success
    json_response = JSON.parse(response.body)

    assert_equal Organization.all.count, json_response['organizations'].count
    assert_equal Organization.first.name, json_response['organizations'][0]['name']
  end

  test 'should show organization' do
    get v1_organization_url(@organization)
    
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @organization.name, json_response['name']
  end

  test 'should create organization' do
    organization_params = {
      organization: {
        name: 'New Organization',
        code: 'ORG002',
        status: 'active'
      }
    }
    post v1_organizations_url, params: organization_params
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal 'New Organization', json_response['name']
  end

  test 'should destroy organization' do
    assert_difference('Organization.count', -1) do
      delete v1_organization_url(@organization)
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 'Organization successfully deleted', json_response['message']
  end

end
