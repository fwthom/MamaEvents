class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    amount = params[:amount].to_i * 100
    payment_method_id = params[:payment_method_id]

    # Create the PaymentIntent
    payment_intent = Stripe::PaymentIntent.create(
      amount: amount,
      currency: 'eur',
      payment_method: payment_method_id,
      confirmation_method: 'automatic',
      confirm: true,
      return_url: success_payments_url
    )
    Payment.create!(
          payment_reference: payment_intent.id,
          amount: amount / 100.0,
          status: payment_intent.status
        )

    render json: { client_secret: payment_intent.client_secret }
  rescue Stripe::StripeError => e

    render json: { error: e.message }, status: :unprocessable_entity
  end

  def success
    render plain: "Payment Successful!"
  end
end
