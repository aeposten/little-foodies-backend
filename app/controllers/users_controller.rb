class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create, :show]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        users = User.all
        render json: users
    end

    def show
        current_user ? (render json: current_user, status: :ok) : (render json: "Not authenticated", status: :unauthorized)
        #     render json: current_user, status: :ok
        # else 
        #     render json: "Not authenticated", status: :unauthorized
        # end
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created 
        else 
            render json: user.errors.full_messages, status: :unprocessable_entity 
        end
    end

    # def update
    #     user = find_user
    #     user.update(user_params)
    #     render json: user
    # end

    def destroy
        activity = find_user
        activity.destroy
        head :no_content
    end

    private

    def user_params
        params.permit(:first_name, :last_name, :username, :email, :password, :passwword_confirmation)
    end

    def find_user
        User.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "User not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
