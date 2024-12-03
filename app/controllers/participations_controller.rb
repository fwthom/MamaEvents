class ParticipationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @participation = Participation.new
  end

  def create
    raise
    @participation = Participation.create(participation_params)
    @participation.status = "created"
    # @participation.token = SecureRandom.urlsafe_base64(16, true)
    if @participation.save
      redirect_to @event, notice: 'Participation enregistrée attente paiment'
    else
      render :new
    end
  end

  def show
    @participation = Participation.all
  end

    def edit
      @participation = Participation.find(params[:id])
      @participant = @participation.participant
      @ticket = @participation.ticket
      @options = @ticket.options
      @orders = @participation.orders
    end

    def update
      @participation = Participation.find(params[:id])
      orders_params = params[:orders] || {}
      # Gérer les options et quantités
      orders_params.each do |option_id, details|
        quantity = details[:quantity].to_i
        next if quantity <= 0
        order = @participation.orders.find_or_initialize_by(option_id: option_id)
        order.update(quantity: quantity)
      end

      # Supprimer les orders avec une quantité nulle ou non incluses dans les paramètres
      @participation.orders.where.not(option_id: orders_params.keys).destroy_all

      #Calcul du montant total
      compute_total_amount

      # Ligne à modifier pour arriver au paiement      
      redirect_to @participation, notice: "Participation mise à jour avec succès."
    end
  private

  def participation_params
    params.require(:participation).permit(:ticket_id, :status, :participant_id, :payment_id)
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email, :token)
  end

  def compute_total_amount
    options_amount = 0
    @participation.orders.each do |order|
      options_amount += order.quantity * order.option.unit_price
    end
    @participation.total_amount = @participation.ticket.unit_price + options_amount
  end
end
