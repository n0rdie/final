class Api::V1::UsersController < ApplicationController
    def create
        User.new(user_params).save
    end

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end