import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["amount"]
  
  setAmount(event) {
    const amount = event.currentTarget.dataset.amount;
    this.amountTarget.value = amount;
  }
}
