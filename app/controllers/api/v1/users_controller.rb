class Api::V1::UsersController < ApplicationController
    def create
        if params[:password_confirmation] == nil
            render json: { error: 'Missing password confirmation' }, status: :bad_request
        else
            user = User.new(user_params)
            if user.save
                render json: UserSerializer.new(user), status: :created
            else
                render json: user.errors, status: :bad_request
            end
        end
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end