class Api::V1::RecipesController < ApplicationController
    def index
        country = nil
        if params[:country]
            country = params[:country]
        else
            country = CountryFacade.random_country.country
        end

        recipes = RecipesFacade.country_search(country)
        render json: RecipeSerializer.new(recipes)
    end
end