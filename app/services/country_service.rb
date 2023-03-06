class CountryService
  def self.random
    response = Faraday.get('https://restcountries.com/v3.1/all')
    JSON.parse(response.body, symbolize_names: true)
  end
end