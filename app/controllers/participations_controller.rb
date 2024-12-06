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
        redirect_to participation_path(@participation), notice: 'Participation enregistrée attente paiement'
        send_participation_message(@participation)
        @participation.bib_number ||= set_bib_number

      else
        render :edit, alert: "Erreur lors de la mise à jour de la participation."
      end
    end


    def send_participation_message(participation)
      @participation = participation
      @participant = @participation.participant
      @ticket = @participation.ticket
      @event_name = @ticket.event.name
      @orders = @participation.orders.group_by { |order| order.option.category }
      @total_price = @orders.values.flatten.sum { |order| order.option.unit_price * order.quantity } + @ticket.unit_price

      email_body = <<~HTML
        <!DOCTYPE html>
        <html lang="fr">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Email Confirmation</title>
        </head>
        <body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f9f9f9; line-height: 1.6;">
          <!-- Pink Top Overlay with Logo -->
          <div style="background-color: #FFDADE; padding: 20px; text-align: center;">
            <a href="https://www.mama-event.me" style="text-decoration: none;">
              <img src="https://mes-amis-mes-amours.fr/wp-content/uploads/2022/02/logo-e1644931773707.png" alt="Mama Events Logo" style="width: 150px; height: auto;">
            </a>
          </div>

          <!-- Main Email Content -->
          <div style="padding: 30px; background-color: #ffffff; margin: 20px; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
            <h1 style="color: #333333; text-align: center;">Bienvenue, #{@participant.first_name}!</h1>
            <h2 style="color: #555555; text-align: center;">Votre participation a bien été enregistrée.</h2>

            <div class="receipt" style="background-color: #fff; border: 2px dotted #000; padding: 20px; margin: 20px auto; width: 50%; max-width: 400px;">
              <div style="border-bottom: 1px solid #000; padding-bottom: 10px; margin-bottom: 10px;">
                <p style="margin: 0; font-weight: bold;">Évènement : #{@event_name}</p>
                <p style="margin: 0; font-weight: bold;">Billet : #{@ticket.name}</p>
                <p style="margin: 0; text-align: right;">#{@ticket.unit_price} €</p>
              </div>

              <!-- Categories -->
              #{@orders.map do |category, orders|
                <<~CATEGORY_HTML
                  <div style="border-bottom: 1px solid #000; padding-bottom: 10px; margin-bottom: 10px;">
                    <h5 style="margin: 0; text-align: left; text-transform: uppercase;">#{category}</h5>
                    #{orders.map do |order|
                      <<~ORDER_HTML
                        <div style="display: flex; justify-content: space-between; margin: 5px 0;">
                          <span>#{order.option.name} x #{order.quantity}</span>
                          <span>#{order.option.unit_price * order.quantity} €</span>
                        </div>
                      ORDER_HTML
                    end.join}
                  </div>
                CATEGORY_HTML
              end.join}

              <div style="border-top: 2px solid #000; padding-top: 10px; font-weight: bold; margin-top: 20px;">
                <div style="display: flex; justify-content: space-between;">
                  <span>Total :</span>
                  <span>#{@total_price} €</span>
                </div>
              </div>
            </div>

            <p style="color: #555555; text-align: center; margin-top: 30px;">
              Si vous n'avez pas encore payé, retrouvez votre récapitulatif et lien de paiement ci-dessous:
            </p>
            <p style="text-align: center; margin-top: 20px;">
              <a href="https://www.mama-event.me/participations/#{@participation.id}" style="background-color: #ff8ba7; color: #ffffff; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold;">Cliquez ici pour y accéder</a>
            </p>
          </div>

          <!-- Pink Bottom Overlay -->
          <div style="background-color: #FFDADE; padding: 20px; text-align: center; margin-top: 30px;">
            <p style="color: #ffffff; font-size: 14px; margin: 0; line-height: 1.8;">
              © 2024 Mama Events. Tous droits réservés. <br>
              <a href="https://www.mama-event.me" style="color: #ffffff; text-decoration: underline; margin-top: 10px; display: inline-block;">Visitez notre site Web</a>
            </p>
          </div>
        </body>
        </html>
      HTML

      mailgun_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
      message_params = {
        from: "mama-bienvenue@#{ENV['MAILGUN_DOMAIN_NAME']}",
        to: @participant.email,
        subject: "Confirmation de participation à #{@event_name}",
        html: email_body
      }

      mailgun_client.send_message(ENV['MAILGUN_DOMAIN_NAME'], message_params)
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
    # Récupérer les participations associées au même ticket (et donc au même évènement)
    max_bib = Participation.where(ticket: @participation.ticket)
    .maximum(:bib_number) || 0

    # Assigner le numéro de dossard
    @participation.bib_number = max_bib + 1
    @participation.save

  end
end
