class V1::ProjectsController < ApplicationController
  before_action :set_organization
  before_action :set_project, only: %i[show update destroy]

  def index
    projects = @organization.projects
    render json: projects
  end

  def show
    render json: @project
  end

  def create
    @project = @organization.projects.new(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @project
      @project.destroy
      render json: { message: 'Project successfully deleted' }, status: :ok
    else
      render json: { error: 'Project not found or already deleted' }, status: :not_found
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_project
    @project = Project.find_by(id: params[:id], organization_id: params[:organization_id])
    return unless @project.nil?

    render json: { error: 'Project not found or already deleted' }, status: :not_found
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
