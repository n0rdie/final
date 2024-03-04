class WeatherService
  def conn
    Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
    end
  end
  
  def get_url(url)
    response = conn.get(url) 
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def weather(lat, lng)
    get_url("/data/2.5/air_pollution?lat=#{lat}&lon=#{lng}&appid=#{Rails.application.credentials.weather[:key]}")
  end
end

# http://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid={API key}