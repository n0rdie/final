class CountryService
  def conn
    Faraday.new(url: 'https://restcountries.com') do |faraday|
      #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
    end
  end
  
  def get_url(url)
    response = conn.get(url) 
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def country(q)
    get_url("/v3.1/name/#{q}?fullText=true")
  end

  def random_country
    response = get_url("/v3.1/all?fields=name")
    response[Random.new.rand(0..response.count-1)]
  end
end

# https://restcountries.com/v3.1/name/India?fullText=true