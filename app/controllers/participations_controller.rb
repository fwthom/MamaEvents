class ParticipationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @participation = Participation.new
  end

  def create
    @participation = Participation.new(participation_params)
    @participation.status = "created"
    # @participation.token = SecureRandom.urlsafe_base64(16, true)
    if @participation.save
      # redirect_to @event, notice: 'Participation enregistrée attente paiment'
      redirect_to participation_path(@participation.participant), notice: 'Participation enregistrée attente paiement'
    else
      render :new
    end
  end

  def show
    @participation = Participation.find(params[:id])
    @participant = @participation.participant
    @orders = @participation.orders
    # @alimentaire = @orders.where(option.category: 'alimentaire')
    # @event = Event.find_by(id: @participation_event)
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
      orders_params.each do |option_id, details|
        quantity = details[:quantity].to_i
        next if quantity <= 0
        order = @participation.orders.find_or_initialize_by(option_id: option_id)
        order.update(quantity: quantity)
      end
      @participation.orders.where.not(option_id: orders_params.keys).destroy_all
      compute_total_amount

      if @participation.save
        redirect_to participation_path(@participation), notice: 'Participation enregistrée attente paiment'
        send_participation_message(@participation)
        @participation.bib_number ||= set_bib_number

      else
        render :edit, alert: "Erreur lors de la mise à jour de la participation."
      end
    end


    def send_participation_message(participation)
      participant = participation.participant
      mailgun_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
      puts'------------------------------'
      puts mailgun_client
      message_params = {
        from: "Mama-hello@#{ENV['MAILGUN_DOMAIN_NAME']}",
        to: participant.email,
        subject: "test email",
        html: "<div class='text-center'> <h1>Bienvenue à #{participation.ticket.event.name}  #{participant.first_name}</h1>
        <h2>Ta participation a bien été enregistrée. N'oublie pas de la finaliser en te rendant sur ce lien
        <a href='http://127.0.0.1:3000/participations/#{participant.id}'>lien</a></h2>
        </div>"
      }

      mailgun_client.send_message ENV['MAILGUN_DOMAIN_NAME'], message_params
    end

private

  def participation_params
    params.require(:participation).permit(:ticket_id, :status, :participant_id, :payment_id)
  end

  def compute_total_amount
    options_amount = 0
    @participation.orders.each do |order|
      options_amount += order.quantity * order.option.unit_price
    end
    @participation.total_amount = @participation.ticket.unit_price + options_amount
  end

  def set_bib_number
    # Récupérer les participations associées au même ticket (et donc au même événement)
    max_bib = Participation.where(ticket: @participation.ticket)
    .maximum(:bib_number) || 0

    # Assigner le numéro de dossard
    @participation.bib_number = max_bib + 1
  end
end
