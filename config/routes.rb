Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/users" => "users#create"
  
  get "/recipes" => "recipes#index"
  post "/recipes" => "recipes#create"
  get "/recipes/:id" => "recipes#show"
  patch "/recipes/:id" => "recipes#update"
  delete "/recipes/:id" => "recipes#destroy"
end
