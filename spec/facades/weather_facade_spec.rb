require 'rails_helper'

RSpec.describe 'WeatherFacade' do 
  it '#get weather search' do
    weather_map = File.read("spec/fixtures/weather_map.json")
    stub_request(:get, "https://api.openweathermap.org/data/2.5/air_pollution?lat=20.0&lon=77.0&appid=#{Rails.application.credentials.weather[:key]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: weather_map, headers: {})

    weather = WeatherFacade.weather_search('India', 'New Delhi', 20.0, 77.0)

    expect(weather).to be_a(WeatherPoro)
    expect(weather.aqi).to eq(2)
    expect(weather.datetime).to eq(1709576227)
    expect(weather.readable_aqi).to eq('Poor')
  end
end