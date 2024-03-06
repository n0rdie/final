class Api::V1::FavoritesController < ApplicationController
    def index
        if params[:api_key] != nil
            user = User.find_by(api_key: params[:api_key])
            if user != nil
                render json: FavoriteSerializer.new(user.favorites), status: :ok
            else
                render json: { failed: 'API Key not found' }, status: :bad_request
            end
        else
            render json: { failed: 'API Key not found' }, status: :bad_request
        end
    end

    def create
        if params[:api_key] != nil
            user = User.find_by(api_key: params[:api_key])
            if user != nil
                favorite = user.favorites.new(favorite_params)
                if favorite.save
                    render json: { success: 'Favorite added successfully' }, status: :created
                else
                    render json: favorite.errors, status: :bad_request
                end
            else
                render json: { failed: 'API Key not found' }, status: :bad_request
            end
        else
            render json: { failed: 'API Key not found' }, status: :bad_request
        end
    end

    private

    def favorite_params
        params.permit(:country, :recipe_link, :recipe_title)
    end
end