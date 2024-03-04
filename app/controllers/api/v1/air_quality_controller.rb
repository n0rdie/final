class Api::V1::AirQualityController < ApplicationController
    def index
        country = CountryFacade.country_search(params[:country])
        weather = WeatherFacade.weather_search(country.country, country.capital, country.lat, country.lng)
        render json: AirQualitySerializer.new(weather)
        
    end
end