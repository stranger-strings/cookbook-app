/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      recipes: []
    };
  },
  mounted: function() {
    axios.get("/recipes").then(
      function(response) {
        this.recipes = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var RecipesShowPage = {
  template: "#recipes-show-page",
  data: function() {
    return {
      recipe: {
        title: "Sample recipe",
        ingredients: ["Sample ingredient"],
        directions: ["Sample directions"]
      }
    };
  },
  mounted: function() {
    axios.get("/recipes/" + this.$route.params.id).then(
      function(response) {
        this.recipe = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var SamplePage = {
  template: "#sample-page",
  data: function() {
    return {
      message: "Welcome to a sample page!"
    };
  },
  mounted: function() {},
  methods: {},
  computed: {}
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/recipes/:id", component: RecipesShowPage },
    { path: "/sample", component: SamplePage }
  ]
});

var app = new Vue({
  el: "#app",
  router: router
});
