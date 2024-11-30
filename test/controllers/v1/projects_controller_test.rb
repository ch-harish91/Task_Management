require 'test_helper'

class V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = Organization.create(name: 'Test Organization')

    @project = Project.create(
      name: 'Test Project',
      description: 'Test Description',
      status: 'active',
      organization: @organization
    )
  end

  test 'should get index' do
    get v1_organization_projects_url(@organization)
    assert_response :success
    projects = JSON.parse(response.body)
    assert_not_nil projects
    assert_equal @project.name, projects.first['name']
    assert_equal @project.description, projects.first['description']
    assert_equal @project.status, projects.first['status']
  end

  test 'should show project' do
    get v1_organization_project_url(@organization, @project)
    assert_response :success
    project = JSON.parse(response.body)
    assert_not_nil project
    assert_equal @project.name, project['name']
    assert_equal @project.description, project['description']
    assert_equal @project.status, project['status']
  end

  test 'should create project' do
    project_params = {
      project: {
        name: 'New Project',
        description: 'Project Description',
        status: 'active'
      }
    }
    assert_difference('Project.count', 1) do
      post v1_organization_projects_url(@organization), params: project_params
    end
    assert_response :created
    project = JSON.parse(response.body)
    assert_equal 'New Project', project['name']
    assert_equal 'Project Description', project['description']
    assert_equal 'active', project['status']
    assert_equal @organization.id, project['organization_id']
  end

  test 'should update project' do
    updated_params = {
      project: {
        name: 'Updated Project Name',
        description: 'Updated Project Description',
        status: 'inactive'
      }
    }
    patch v1_organization_project_url(@organization, @project), params: updated_params
    assert_response :success
    @project.reload
    assert_equal 'Updated Project Name', @project.name
    assert_equal 'Updated Project Description', @project.description
    assert_equal 'inactive', @project.status
  end

  test 'should delete project' do
    assert_difference('Project.count', -1) do
      delete v1_organization_project_url(@organization, @project)
    end
    assert_response :success
    assert_not Project.exists?(@project.id)
  end
end
