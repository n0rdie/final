class WeatherFacade

  def self.weather_search(country, capital, lat, lng)
    service = WeatherService.new
    json = service.weather(lat, lng)

    @weather = WeatherPoro.new(json) 
  end
end