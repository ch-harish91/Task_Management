class V1::OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show update destroy]

  def index
    organizations = Organization.all
    render json: {organizations: organizations}
  end

  def show
    return not_found unless @organization

    render json: @organization
  end

  def create
    organization = Organization.new(organization_params)
    if organization.save
      render json: organization, status: :created
    else
      render json: { errors: organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return not_found unless @organization

    if organization.update(organization_params)
      render json: organization, status: :ok
    else
      render json: { error: organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return not_found if @organization.nil?

    @organization.destroy
    render json: { message: 'Organization successfully deleted' }, status: :ok
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :code, :status)
  end

  def set_organization
    @organization = Organization.find_by(id: params[:id])
  end
end
