require 'rails_helper'

RSpec.describe CountryPoro do
  it 'creates an country poro based on attributes' do
    attr = {
      "name": {
        "common": "India",
      },
      "capital": [
        "New Delhi"
      ],
      "latlng": [
        20.0,
        77.0
      ]
    }

    country = CountryPoro.new(attr)
    expect(country).to be_a(CountryPoro)
    expect(country.country).to eq("India")
    expect(country.capital).to eq("New Delhi")
    expect(country.lat).to eq(20.0)
    expect(country.lng).to eq(77.0)
  end

  it 'creates an country poro with only name' do
    attr = {
      "name": {
        "common": "Cyprus",
      }
    }

    country = CountryPoro.new(attr)
    expect(country).to be_a(CountryPoro)
    expect(country.country).to eq("Cyprus")
    expect(country.capital).to eq(nil)
    expect(country.lat).to eq(nil)
    expect(country.lng).to eq(nil)
  end
end