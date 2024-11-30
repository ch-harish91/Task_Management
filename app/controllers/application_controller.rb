class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def not_found
    render json: { error: 'record not found' }, status: :not_found
  end
end
