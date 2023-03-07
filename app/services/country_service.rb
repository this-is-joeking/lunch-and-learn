class CountryService
  def self.all
    response = Faraday.get('https://restcountries.com/v3.1/all')
    JSON.parse(response.body, symbolize_names: true)
  end
end
