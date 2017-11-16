Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/recipes" => "recipes#index"

  get "/one_recipe_url" => "recipes#one_recipe_method"
  get "/one_recipe_url_segment_url/:input_recipe_id" => "recipes#one_recipe_method"
end
