class Api::V1::UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            render json: UserSerializer.new(user), status: :created
        else
            render json: user.errors, status: :bad_request
        end
    end

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end