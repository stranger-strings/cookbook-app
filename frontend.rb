require "unirest"
require "pp"

system "clear"
puts "Welcome to the Recipe app! Select an option:"
puts "[1] See all recipes"
puts "[2] Create a recipe"
puts "[3] See one recipe"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/recipes")
  recipes = response.body
  pp recipes
elsif input_option == "2"
  params = {}
  print "Enter a recipe title: "
  params["input_title"] = gets.chomp
  print "Enter a recipe chef: "
  params["input_chef"] = gets.chomp
  print "Enter a recipe ingredients: "
  params["input_ingredients"] = gets.chomp
  print "Enter a recipe directions: "
  params["input_directions"] = gets.chomp
  response = Unirest.post("http://localhost:3000/recipes", parameters: params)
  recipe = response.body
  pp recipe
elsif input_option == "3"
  print "Which recipe id do you want to see? "
  recipe_id = gets.chomp
  response = Unirest.get("http://localhost:3000/recipes/#{recipe_id}")
  recipe = response.body
  pp recipe
end
