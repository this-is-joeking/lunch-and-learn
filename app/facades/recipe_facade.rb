class RecipeFacade
  def self.by_country(country)
    recipes_data = RecipeService.by_country(country)
    recipes_data[:hits].map do |recipe_data|
      Recipe.new(recipe_data, country)
    end
  end
end
