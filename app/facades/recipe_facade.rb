class RecipeFacade
  def self.by_country(country)
    country = random_country unless country
    
    recipes_data = RecipeService.by_country(country)
    recipes_data[:hits].map do |recipe_data|
      Recipe.new(recipe_data, country)
    end
  end

  def self.random_country
    countries_data = CountryService.all
    countries_data[random_num(countries_data.count)][:name][:common]
  end

  private_class_method

  def self.random_num(max)
    rand(1..max)
  end
end
