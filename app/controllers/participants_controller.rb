class ParticipantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]


  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def new
    @participant = Participant.new
    @event = Event.find(params[:event_id])
    @charity = Charity.find(params[:charity_id])
  end

  def create
    @charity = Charity.find(params[:charity_id])
    @event = Event.find(params[:event_id])

    @participant = Participant.create(participant_params)

    @participant.event = @event
    if @participant.save
      @ticket = Ticket.find(params[:ticket_id])
      Participation.create(ticket: @ticket, participant: @participant, payment_id: 2)
      raise
      if Participation.save
        redirect_to @event, notice: 'Votre participation a été enregistrée'
        # redirect_to @event, notice: 'Votre participation a été enregistrée'
      else
        render :new, alert: "Votre participation n'a pas abouti"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update(participant_params)
      redirect_to @participant, notice: 'Le participant a été mise à jour avec succès.'
    else
      render :edit
    end
  end



  def destroy
    @participant = Participant.find(params[:id])
      if @participant.destroy
        redirect_to dashboard_path, notice: 'Participant supprimé'
      else
        redirect_to dashboard_path, alert: 'Suppression impossible.'
      end
  end

  private

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email)
  end
end
