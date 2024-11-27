import { Application } from "@hotwired/stimulus";

const application = Application.start();

import StripeController from "./stripe_controller";

application.register("stripe", StripeController);

console.log("Stimulus controllers are being registered");
