require "rails_helper"

RSpec.describe "Api::V1::air_quality", type: :request do
    it "can pull city name" do
        rest_countries = File.read("spec/fixtures/rest_countries.json")
        stub_request(:get, "https://restcountries.com/v3.1/name/India?fullText=true").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: rest_countries, headers: {})

        weather_map = File.read("spec/fixtures/weather_map.json")
         stub_request(:get, "https://api.openweathermap.org/data/2.5/air_pollution?lat=20.0&lon=77.0&appid=#{Rails.application.credentials.weather[:key]}").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
            }).
          to_return(status: 200, body: weather_map, headers: {})

        get "/api/v1/air_quality?country=India", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        
        expect(json_response['data']['id']).to eq('null')
        expect(json_response['data']['type']).to eq('air_quality')
        expect(json_response['data']['attributes']['aqi']).to eq(2)
        expect(json_response['data']['attributes']['datetime']).to eq(1709576227)
        expect(json_response['data']['attributes']['readable_aqi']).to eq('Poor')
    end
end