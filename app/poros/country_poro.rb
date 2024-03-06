class CountryPoro
    attr_reader :country,
                :capital,
                :lat,
                :lng
  
    def initialize(data)
        @country = data[:name][:common]

        @capital = nil
        if data[:capital]
            @capital = data[:capital].first
        end
        
        @lat = nil
        @lng = nil
        if data[:latlng]
            @lat = data[:latlng].first
            @lng = data[:latlng].last
        end
    end
end