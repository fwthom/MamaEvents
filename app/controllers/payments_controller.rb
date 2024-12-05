class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @payable = find_payable
    if @payable.nil?
      redirect_to root_path, alert: "Aucun élément payable trouvé. Veuillez réessayer."
      return
    end
    @payment = Payment.new
  end


  def create
    amount = params[:amount].to_i * 100
    amount = amount.to_i
    payment_method_id = params[:payment_method_id]

    payment_intent = Stripe::PaymentIntent.create(
      amount: amount,
      currency: 'eur',
      payment_method: payment_method_id,
      confirmation_method: 'automatic',
      confirm: true,
      return_url: success_payments_url
    )
    @payment = Payment.create!(
      payment_reference: payment_intent.id,
      amount: amount / 100.0,
      status: payment_intent.status,
      payable: find_payable
    )

    render json: { client_secret: payment_intent.client_secret }
  rescue Stripe::StripeError => e

    render json: { error: e.message }, status: :unprocessable_entity
  end

  def success
    render plain: "Payment Successful!"
  end

  private

  def find_payable
    if params[:donation_id].present?
      Donation.find_by(id: params[:donation_id])
    elsif params[:participation_id].present?
      Participation.find_by(id: params[:participation_id])
    else
      nil
    end
  end


  def calculate_amount(payable)
    if payable.is_a?(Donation)
      (payable.amount * 100).to_i
    elsif payable.is_a?(Participation)
      (payable.total_amount * 100).to_i
    else
      Rails.logger.error "Unsupported payable type: #{payable.inspect}"
      raise ArgumentError, "Type de paiement non pris en charge"
    end
  end

  def update_participation_status
    @payable.update(status: "confirmed")
  end
end
