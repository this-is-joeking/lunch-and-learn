class ImageService
  def self.search(query)
    client = Pexels::Client.new
    response = client.photos.search(query, per_page: 10)
    JSON.parse(response.to_json, symbolize_names: true)
  end
end