require "unirest"
require "pp"

while true
  system "clear"
  puts "Welcome to the Recipe app! Select an option:"
  puts "[1] See all recipes"
  puts "  [1.1] Search recipes by title"
  puts "[2] Create a recipe"
  puts "[3] See one recipe"
  puts "[4] Update a recipe"
  puts "[5] Destroy a recipe"
  puts
  puts "[signup] Signup (create a user)"
  puts "[login] Login (create a JSON web token)"
  puts "[logout] Logout (erase the JSON web token)"
  puts
  puts "[q] Quit"

  input_option = gets.chomp

  if input_option == "1"
    response = Unirest.get("http://localhost:3000/recipes")
    recipes = response.body
    pp recipes
  elsif input_option == "1.1"
    print "Enter search terms: "
    search_terms = gets.chomp
    puts "Here are the matching recipes:"
    response = Unirest.get("http://localhost:3000/recipes?search=#{search_terms}")
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
  elsif input_option == "4"
    print "Which recipe id do you want to update? "
    recipe_id = gets.chomp
    
    response = Unirest.get("http://localhost:3000/recipes/#{recipe_id}")
    recipe = response.body

    params = {}
    print "Enter the updated recipe title (#{recipe["title"]}): "
    params["input_title"] = gets.chomp
    print "Enter the updated recipe chef (#{recipe["chef"]}): "
    params["input_chef"] = gets.chomp
    print "Enter the updated recipe ingredients (#{recipe["ingredients"]}): "
    params["input_ingredients"] = gets.chomp
    print "Enter the updated recipe directions (#{recipe["directions"]}): "
    params["input_directions"] = gets.chomp
    
    params.delete_if { |key, value| value.empty? }

    response = Unirest.patch("http://localhost:3000/recipes/#{recipe_id}", parameters: params)
    recipe = response.body
    pp recipe
  elsif input_option == "5"
    print "Which recipe id do you want to destroy? "
    recipe_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/recipes/#{recipe_id}")
    pp response.body
  elsif input_option == "signup"
    params = {}
    print "Name: "
    params[:name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    print "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    pp response.body
  elsif input_option == "login"
    puts "Login to the app"
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()
  elsif input_option == "q"
    puts "Goodbye!"
    break
  end
  puts 
  puts "Press enter to continue"
  gets.chomp
end
