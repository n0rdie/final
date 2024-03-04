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

        get "/api/v1/air_quality?country=India", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
    end
end