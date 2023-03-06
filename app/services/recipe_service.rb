class RecipeService
  def self.conn
    Faraday.new(url: 'https://api.edamam.com',
                params: { app_id: ENV['RECIPE_APP_ID'], app_key: ENV['RECIPE_API_KEY'] })
  end

  def self.by_country(country)
    response = conn.get('/api/recipes/v2', { type: 'any', q: country })
    parse(response)
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
