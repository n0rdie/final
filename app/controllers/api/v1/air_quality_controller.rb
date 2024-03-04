class Api::V1::AirQualityController < ApplicationController
    def index
        country = CountryFacade.country_search(params[:country])
    end
end