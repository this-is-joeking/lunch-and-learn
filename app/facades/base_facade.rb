class BaseFacade
  def self.valid?(country)
    country_data = CountryService.find(country)
    country_data == 200
  end
end
