class RecipeService
  def self.conn
    Faraday.new(url: 'https://api.edamam.com',
                params: { app_id: ENV['recipe_app_id'], app_key: ENV['recipe_api_key'] })
  end

  def self.by_country(country)
    response = conn.get('/api/recipes/v2', { type: 'any', q: country })
    parse(response)
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
