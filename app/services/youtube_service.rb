class YoutubeService
    def conn
        Faraday.new(url: 'https://www.googleapis.com') do |faraday|
            #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
        end
    end
    
    def get_url(url)
        response = conn.get(url) 
        
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def search(country)
        get_url("/youtube/v3/search?key=#{Rails.application.credentials.youtube[:key]}&q=#{country}&part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw")
    end
end