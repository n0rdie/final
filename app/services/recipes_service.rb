class RecipesService
  def conn
    Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
    end
  end
  
  def get_url(url)
    response = conn.get(url) 
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def recipes(country)
    get_url("https://api.edamam.com/api/recipes/v2?app_key=#{Rails.application.credentials.edamam[:key]}&app_id=#{Rails.application.credentials.edamam[:id]}&type=public&q=#{country}}")
  end
end