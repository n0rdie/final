class Api::V1::RecipesController < ApplicationController
    def index
        recipes = RecipesFacade.country_search(params[:country])
        render json: RecipeSerializer.new(recipes)
    end
end