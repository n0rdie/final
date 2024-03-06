class CountryFacade

  def self.country_search(q)
    service = CountryService.new
    json = service.country(q)

    @country = CountryPoro.new(json.first) 
  end

  def self.random_country
    service = CountryService.new
    json = service.random_country

    @country = CountryPoro.new(json) 
  end
end