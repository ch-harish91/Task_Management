class V1::ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    user = User.find_by(id: params[:user_id])

    if user&.profile
      render json: { profile: user.profile }
    else
      render json: { error: "Profile not found for user #{params[:user_id]}" }, status: :not_found
    end
  end

  def create
    user = User.find(params[:user_id])

    if user.profile
      render json: { error: 'Profile already exists' }, status: :unprocessable_entity
    else

      profile = Profile.new(profile_params.merge(user_id: user.id))

      if profile.save
        render json: profile, status: :created
      else
        render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    user = User.find_by(id: params[:user_id])
    if user && user.profile && user.profile.update(profile_params)
      render json: { message: 'Profile updated', profile: user.profile }
    else
      render json: { error: user&.profile&.errors&.full_messages || 'Profile not found' },
             status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:user_id])
    if user&.profile&.destroy
      render json: { message: 'Profile deleted' }
    else
      render json: { error: 'Profile not found' }, status: :not_found
    end
  end
end

private

def profile_params
  params.require(:profile).permit(:first_name, :last_name, :phone_number)
end
