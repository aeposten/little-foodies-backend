class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_credential_response

    def create
        user = User.find_by_username(params[:username])
        user&.authenticate(params[:password])
        session[:user_id] = user.id 
        render json: user, status: :ok
    end
  
    def destroy
        session.delete :user_id
    end

    private

    def render_invalid_credential_response(unauthorized)
        render json: { errors: unauthorized.record.errors.full_messages }, status: :unauthorized
    end
end
