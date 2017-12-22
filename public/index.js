/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      recipes: []
    };
  },
  created: function() {
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
  created: function() {
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
  created: function() {},
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var RecipesNewPage = {
  template: "#recipes-new-page",
  data: function() {
    return {
      title: "",
      chef: "",
      ingredients: "",
      directions: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        input_title: this.title,
        input_chef: this.chef,
        input_ingredients: this.ingredients,
        input_directions: this.directions
      };
      axios
        .post("/recipes", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var RecipesEditPage = {
  template: "#recipes-edit-page",
  data: function() {
    return {
      title: "",
      chef: "",
      ingredients: "",
      directions: "",
      errors: []
    };
  },
  created: function() {
    axios.get("/recipes/" + this.$route.params.id).then(
      function(response) {
        this.title = response.data.title;
        this.chef = response.data.chef;
        this.ingredients = response.data.ingredients;
        this.directions = response.data.directions;
      }.bind(this)
    );
  },
  methods: {
    submit: function() {
      var params = {
        input_title: this.title,
        input_chef: this.chef,
        input_ingredients: this.ingredients,
        input_directions: this.directions
      };
      axios
        .patch("/recipes/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/recipes/new", component: RecipesNewPage },
    { path: "/recipes/:id", component: RecipesShowPage },
    { path: "/recipes/:id/edit", component: RecipesEditPage },
    { path: "/sample", component: SamplePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ]
});

var app = new Vue({
  el: "#app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
