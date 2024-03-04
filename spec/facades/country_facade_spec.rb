require 'rails_helper'

RSpec.describe 'CountryFacade' do 
  it '#get country search' do
    rest_countries = File.read("spec/fixtures/rest_countries.json")
    stub_request(:get, "https://restcountries.com/v3.1/name/India?fullText=true").
     with(
       headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
       }).
     to_return(status: 200, body: rest_countries, headers: {})

    search_term = 'India' 

    country = CountryFacade.country_search(search_term)

    expect(country).to be_a(CountryPoro)
    expect(country.country).to eq('India')
    expect(country.capital).to eq('New Delhi')
    expect(country.lat).to eq(20.0)
    expect(country.lng).to eq(77.0)
  end
end