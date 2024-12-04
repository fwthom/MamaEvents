import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-calpin"
export default class extends Controller {
  static targets = ["link"];

  connect() {
    console.log("NavbarController connecté !");

  }

  setActive(event) {
    event.preventDefault();
    this.linkTargets.forEach(link => link.classList.remove("active"));
    event.currentTarget.classList.add("active");
  }
}
