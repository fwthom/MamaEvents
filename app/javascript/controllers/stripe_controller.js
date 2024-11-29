import { Controller } from "@hotwired/stimulus";
import { loadStripe } from "@stripe/stripe-js";

export default class extends Controller {
  static targets = ["paymentElement", "cardNumber", "cardExpiry", "cardCvc", "form", "error", "amount"];

  async connect() {
    console.log("Stripe controller connected");

    this.stripe = await loadStripe("pk_test_51QInwzKwwn6hW5STY5j6UE2Lnb8Sb5XrEb2M8GZLSxXqIsDVfRiuMnlKPcUv28YmncQJwWreO0Hoytfe2kKiQAxA00ajGclBCC");
    this.elements = this.stripe.elements();

    // Styling for individual Elements
    const style = {
      base: {
        fontSize: "16px",
        color: "#32325d",
        "::placeholder": {
          color: "#aab7c4",
        },
      },
      invalid: {
        color: "#fa755a",
        iconColor: "#fa755a",
      },
    };

    // Create and mount individual Elements
    this.cardNumber = this.elements.create("cardNumber", { style });
    this.cardNumber.mount(this.cardNumberTarget);

    this.cardExpiry = this.elements.create("cardExpiry", { style });
    this.cardExpiry.mount(this.cardExpiryTarget);

    this.cardCvc = this.elements.create("cardCvc", { style });
    this.cardCvc.mount(this.cardCvcTarget);

    console.log("Stripe Elements mounted");
  }

  async submit(event) {
    event.preventDefault();

    try {
      const amount = this.amountTarget?.value;

      console.log("Amount Target Value:", amount);

      if (!amount || isNaN(parseFloat(amount))) {
        this.errorTarget.textContent = "Invalid or missing amount.";
        return;
      }

      const { paymentMethod, error } = await this.stripe.createPaymentMethod({
        type: "card",
        card: this.cardNumber, // Use the individual cardNumber element
      });

      if (error) {
        this.errorTarget.textContent = error.message;
        return;
      }

      const response = await fetch("/payments", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
        },
        body: JSON.stringify({
          amount: parseFloat(amount),
          payment_method_id: paymentMethod.id,
        }),
      });

      const { client_secret, error: serverError } = await response.json();

      if (serverError) {
        this.errorTarget.textContent = serverError;
        return;
      }

      const { paymentIntent, error: confirmationError } = await this.stripe.confirmCardPayment(client_secret);

      if (confirmationError) {
        this.errorTarget.textContent = confirmationError.message;
        return;
      }

      if (paymentIntent && paymentIntent.status === "succeeded") {
        console.log("Payment successful, redirecting...");
        window.location.href = "/payments/success";
      } else {
        console.log("Waiting for redirection...");
      }
    } catch (e) {
      console.error("Unexpected error:", e);
      this.errorTarget.textContent = "An unexpected error occurred.";
    }
  }
}
