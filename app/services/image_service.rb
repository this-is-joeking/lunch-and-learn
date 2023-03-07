class ImageService
  def self.conn
    Faraday.new(url: 'https://api.pexels.com', headers: { 'Authorization' => ENV['PEXELS_API_KEY'] })
  end
  def self.search(query)
    response = conn.get('/v1/search', { query: query, per_page: 10 })
    
    JSON.parse(response.body, symbolize_names: true)
  end
end