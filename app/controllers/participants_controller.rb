class ParticipantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :new, :create]


  def index
    @participants = Participant.all

  end

  def show
    participant = Participant.where(token: params[:id])
    @participant = participant.first
    participation = Participation.where(participant_id: @participant.id)
    @participation = participation.first
    ticket = Ticket.where(id: @participation.ticket_id)
    @ticket = ticket.first
    event = Event.where(id: @ticket.event_id)
    @event = event.first
    @goodies = ['frites', 'boisson']
  end

  def new
    @participant = Participant.new
    @event = Event.find(params[:event_id])
    @ticket_id = params[:ticket_id] 

  end

  def create
    @event = Event.find(params[:event_id])
    @participant = Participant.create(participant_params)
    @participant.event = @event
    if @participant.save!
      @participant.status = "created"
      ticket = Ticket.find(params[:ticket_id])
      @participation = Participation.create(participant: @participant, ticket: ticket, status: "created")
      url = "/participants/#{@participant.token}"
      flash[:notice] = url
      redirect_to edit_participation_path(@participation)
    else
      raise
      render :new, status: :unprocessable_entity
    end
  end



  def edit
    @participant = Participant.find_by(token: params[:token])
    @participations = Participation.where(participant: @participant)
    @ticket = Ticket.where(participation_id: @participation_ids)
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
    params.require(:participant).permit(:first_name, :last_name, :email, :team)
  end
end
