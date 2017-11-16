class RecipesController < ApplicationController
  def one_recipe_method
    recipe_id = params["input_recipe_id"]
    recipe = Recipe.find_by(id: recipe_id)
    render json: recipe.as_json
  end
end
