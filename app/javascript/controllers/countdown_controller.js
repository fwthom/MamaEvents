import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = ["timer"];
  static values = { eventDate: String };

  connect() {
    console.log("Stimulus connecté !");
    console.log("Date de l'événement :", this.eventDateValue);

    if (!this.eventDateValue) {
      console.error("Aucune date fournie !");
      return;
    }

    this.startCountdown();
  }

  startCountdown() {
    const eventDate = new Date(this.eventDateValue).getTime();
    const updateTimer = () => {
      const now = new Date().getTime();
      const distance = eventDate - now;

      if (distance < 0) {
        this.timerTarget.textContent = "FINI";
        clearInterval(this.interval);
        return;
      }

      const days = Math.floor(distance / (1000 * 60 * 60 * 24));
      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((distance % (1000 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000)) / 1000);

      this.timerTarget.textContent = `${days}j ${hours}h ${minutes}m ${seconds}s`;
    };

    this.interval = setInterval(updateTimer, 1000);
    updateTimer();
  }

  disconnect() {
    clearInterval(this.interval);
  }
}
