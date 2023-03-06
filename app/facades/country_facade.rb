class CountryFacade
  def self.random
    countries_data = CountryService.random
    random_num = rand(1..countries_data.count)
    countries_data[random_num][:name][:common]
  end
end