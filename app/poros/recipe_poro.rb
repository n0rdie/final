class RecipePoro
    attr_reader :id,
                :title,
                :url,
                :country,
                :image
  
    def initialize(data, country)
        @id = 'null'
        @country = country
        @title = data[:label]
        @image = data[:image]
        @url = data[:url]
    end
end