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
      # redirect_to @event, notice: 'Participation enregistrée attente paiment'
      redirect_to participation_path(Participation.last.token), notice: 'Participation enregistrée attente paiment'
    else
      render :new
    end
  end

  def show
    # @participations = Participation.all
    @participation = Participation.find_by(token: params[:id])
    @participant = @participation.participant
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

    def send_participation_message(participant)

      mailgun_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']

      message_params = {
        from: "vincent@#{ENV['MAILGUN_DOMAIN_NAME']}",
        to: "#{participant.email}",
        subject: "this is a test email",
        text: "coucou this is a test email"
      }

      mailgun_client.send_message ENV['MAILGUN_DOMAIN_NAME'], message_params
      # redirect_to participation_path, notice: "#{Participant.last.first_name}"
      # redirect_to participation_path(token: Participant.last.token), notice: "#{Participant.last.first_name}"
      redirect_to participation_path(token: Participant.last.token), notice: "Bienvenue #{Participant.last.first_name}"

      # mailgun_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']

      # message_params = {
      #   from: "vincent@#{ENV['MAILGUN_DOMAIN_NAME']}",
      #   to: participant.email,
      #   subject: "this is a test email",
      #   text: "coucou this is a test email"
      # }

      # mailgun_client.send_message ENV['MAILGUN_DOMAIN_NAME'], message_params
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
