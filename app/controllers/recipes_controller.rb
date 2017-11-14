class RecipesController < ApplicationController
  def one_recipe_method
    recipe = Recipe.second
    render json: recipe.as_json
  end
end
