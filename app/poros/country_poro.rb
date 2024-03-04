class CountryPoro
    attr_reader :country,
                :capital,
                :lat,
                :lng
  
    def initialize(data)
        @country = data[:name][:common]
        @capital = data[:capital].first
        @lat = data[:latlng].first
        @lng = data[:latlng].last
    end
end