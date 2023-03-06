class CountryFacade
  def self.random
    countries_data = CountryService.random
    countries_data[random_num(countries_data.count)][:name][:common]
  end

  private
  
  def self.random_num(max)
    rand(1..max)
  end
end