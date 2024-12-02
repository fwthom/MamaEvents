// import { Application } from "@hotwired/stimulus";
// const application = Application.start();
import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"
import "controllers"

console.log("Stimulus is initialized");

// import StripeController from "./controllers/stripe_controller";
// application.register("stripe", StripeController);

// import controllers from "./controllers";
// application.load(controllers);

console.log("Stimulus is initialized and controllers are loaded");
