class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: { users: users }
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: { user: user }
    else
      render json: { error: 'user is not found' }
    end
  end

  def create
    user = User.new(user_params)
    user.organization = Organization.first
    if user.save
      render json: { message: 'user created', user: user }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])
    # if user
    #   user.update
    # end
    if user && user.update(user_params)
      render json: { message: 'User updated', user: user }
    else
      render json: { error: user&.errors&.full_messages || 'User not found' }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
      render json: { message: 'user deleted' }
    else
      render json: { error: 'user not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:users).permit(:email)
  end
end
