/* global axios */

axios.get("http://localhost:3000/recipes").then(function(response) {
  var recipes = response.data;
  console.log(recipes);

  var template = document.querySelector("#recipe-card");
  var recipeContainer = document.querySelector(".row");

  recipes.forEach(function(recipe) {
    var clone = template.content.cloneNode(true);

    clone.querySelector(".card-title").innerText = recipe.title;
    clone.querySelector(".card-img-top").src = recipe.image;
    clone.querySelector(".ingredients").innerText = recipe.ingredients;
    clone.querySelector(".directions").innerText = recipe.directions;

    recipeContainer.appendChild(clone);
  });
});
