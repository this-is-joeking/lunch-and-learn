class CountryFacade
  def self.random
    countries_data = CountryService.all
    countries_data[random_num(countries_data.count)][:name][:common]
  end

  private_class_method

  def self.random_num(max)
    rand(1..max)
  end
end
