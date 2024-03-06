class UnsplashService
    def conn
        Faraday.new(url: 'https://api.unsplash.com') do |faraday|
            #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
        end
    end
    
    def get_url(url)
        response = conn.get(url) 
        
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def search(country)
        get_url("/search/photos/?query=#{country}&client_id=#{Rails.application.credentials.unsplash[:access_key]}")
    end
end