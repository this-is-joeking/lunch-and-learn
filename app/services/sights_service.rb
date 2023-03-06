class SightsService
  def self.conn
    Faraday.new(url: 'https://api.geoapify.com',
                params: { apiKey: ENV['places_api_key'] })
  end

  def self.sights_near(lon, lat)
    response = conn.get("/v2/places", {
        categories: 'tourism.sights',
        filter: "circle:#{lon},#{lat},1000",
      })
    JSON.parse(response.body, symbolize_names: true)
  end
end