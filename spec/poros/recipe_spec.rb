require 'rails_helper'

RSpec.describe Recipe do
  it 'exists with attributes' do
    recipe_data = {:recipe=>
      {:uri=>"http://www.edamam.com/ontologies/edamam.owl#recipe_1cb0bfc335666ef2f1ff31f4ba7ed4a5",
       :label=>"Baked Italy",
       :image=>
        "https://edamam-product-images.s3.amazonaws.com/web-img/0d8/0d8f382870e658d838cb18c9587558ac.JPG",
       :source=>"Food52",
       :url=>"https://food52.com/recipes/10380-baked-italy"}
          }
    
    recipe = Recipe.new(recipe_data, 'italy')

    expect(recipe).to be_a Recipe
    expect(recipe.id).to eq(nil)
    expect(recipe.title).to eq('Baked Italy')
    expect(recipe.url).to eq('https://food52.com/recipes/10380-baked-italy')
    expect(recipe.country).to eq('italy')
    expect(recipe.image).to eq('https://edamam-product-images.s3.amazonaws.com/web-img/0d8/0d8f382870e658d838cb18c9587558ac.JPG')
  end
end