class DonationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @donation = Donation.new
    @charity = Charity.first
  end

  def create
    @donation = Donation.new(donation_params)

    if @donation.save
      redirect_to new_payment_path(donation_id: @donation.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:first_name, :last_name, :address, :postal_code, :city, :amount)
  end
end
