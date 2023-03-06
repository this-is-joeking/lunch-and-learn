class CountryFacade
  def self.random
    countries_data = CountryService.all
    countries_data[random_num(countries_data.count)][:name][:common]
  end

  def self.get_capital(country)
    country_data = CountryService.find(country)
    { capital: country_data[0][:capital][0],
      latitude: country_data[0][:capitalInfo][:latlng][0],
      longitude: country_data[0][:capitalInfo][:latlng][1] }
  end

  private

  def self.random_num(max)
    rand(1..max)
  end
end