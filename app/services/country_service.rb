class CountryService
  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def self.all
    response = conn.get('/v3.1/all')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find(country)
    response = conn.get("/v3.1/name/#{country}", { fullText: true })
    response.status
  end
end
