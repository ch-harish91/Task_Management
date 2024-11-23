class V1::OrganizationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    organizations = Organization.all
    render json: organizations
  end

  def show
    organization = Organization.find_by(id: params[:id])
    if organization
      render json: organization
    else
      render json: { error: 'Organization not found' }, status: :not_found
    end
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
    organization = Organization.find_by(id: params[:id])

    if organization
      if organization.update(organization_params)
        render json: organization, status: :ok
      else
        render json: { error: organization.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Organization not found' }, status: :not_found
    end
  end

  def destroy
    organization = Organization.find_by(id: params[:id])

    if organization
      organization.destroy
      render json: { message: 'Organization successfully deleted' }, status: :ok
    else
      render json: { error: 'Organization not found' }, status: :not_found
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :code, :status)
  end
end
