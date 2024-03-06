class Api::V1::LearningResourcesController < ApplicationController
    def index
        country = nil
        if params[:country]
            country = params[:country]
        else
            country = CountryFacade.random_country.country
        end

        learning_resources = LearningResourcesFacade.country_search(country)
        render json: LearningResourcesSerializer.new(learning_resources)
    end
end