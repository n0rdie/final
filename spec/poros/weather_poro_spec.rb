require 'rails_helper'

RSpec.describe WeatherPoro do
  it 'creates an weather poro based on attributes' do
    attr = {
      "coord": {
          "lon": 77,
          "lat": 20
      },
      "list": [
          {
              "main": {
                  "aqi": 2
              },
              "components": {
                  "co": 303.75,
                  "no": 0,
                  "no2": 4.76,
                  "o3": 85.12,
                  "so2": 7.87,
                  "pm2_5": 12.99,
                  "pm10": 18.76,
                  "nh3": 7.6
              },
              "dt": 1709576227
          }
      ]
  }

    weather = WeatherPoro.new(attr)
    expect(weather).to be_a(WeatherPoro)
    expect(weather.aqi).to eq(2)
    expect(weather.datetime).to eq(1709576227)
    expect(weather.readable_aqi).to eq('Poor')
  end
end