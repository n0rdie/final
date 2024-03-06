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
        elsif @aqi == 2
            @readable_aqi = 'Poor'
        end
    end
end