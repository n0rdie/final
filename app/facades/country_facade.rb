class CountryFacade

  def self.country_search(q)
    service = CountryService.new
    json = service.country(q)

    @country = CountryPoro.new(json.first) 
  end
end