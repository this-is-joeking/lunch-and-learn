class CountryFacade
  def self.random
    countries_data = CountryService.all
    countries_data[random_num(countries_data.count)][:name][:common]
  end

  def self.get_capital(country)
    country_data = CountryService.find(country)
    # insert logic to pull the capital out of response
    
  end

  private

  def self.random_num(max)
    rand(1..max)
  end
end