class SightsService
  def self.conn
    Faraday.new(url: 'https://api.geoapify.com',
                params: { apiKey: ENV['places_api_key'] })
  end

  def self.sights_near(lon, lat)
    response = conn.get("/v2/places", {
        categories: 'tourism.sights',
        filter: "circle:#{lon},#{lat},20000",
        bias: "proximity:#{lon},#{lat}"
      })
    JSON.parse(response.body, symbolize_names: true)
  end
end