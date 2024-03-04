class WeatherPoro
    attr_reader :id,
                :aqi,
                :datetime,
                :readable_aqi
  
    def initialize(data)
        @id = 'null'

        @aqi = data[:list].first[:main][:aqi]
        @datetime = data[:list].first[:dt]

        if @aqi == 1
            @readable_aqi = 'Very Poor'
        elsif @aqi == 2
            @readable_aqi = 'Poor'
        elsif @aqi == 3
            @readable_aqi = 'Moderate'
        elsif @aqi == 4
            @readable_aqi = 'Fair'
        elsif @aqi == 5
            @readable_aqi = 'Good'
        else
            @readable_aqi = 'readable_aqi failed'
        end
    end
end