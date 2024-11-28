import { Application } from "@hotwired/stimulus";
const application = Application.start();
console.log("Stimulus is initialized");

import StripeController from "./controllers/stripe_controller";
application.register("stripe", StripeController);

console.log("Stimulus is initialized and controllers are loaded");

import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"
