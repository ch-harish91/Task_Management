class V1::ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user

  def show
    if @user&.profile
      render json: { profile: @user.profile }
    else
      render json: { error: "Profile not found for user #{params[:user_id]}" }, status: :not_found
    end
  end

  def create
    if @user.profile
      render json: { error: 'Profile already exists' }, status: :unprocessable_entity
    else
      profile = Profile.new(profile_params.merge(user_id: @user.id))
      if profile.save
        render json: profile, status: :created
      else
        render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    if @user.profile.update(profile_params)
      render json: { message: 'Profile updated', profile: @user.profile }
    else
      render json: { error: user&.profile&.errors&.full_messages || 'Profile not found' },
             status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number)
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
