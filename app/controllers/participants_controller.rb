class ParticipantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @event = Event.find(params[:event_id])
    @participant = Participant.new
    @ticket_id = params[:ticket_id] 
  end

  def create
    @event = Event.find(params[:event_id])
    @participant = Participant.new(participant_params)
    @participant.event = @event
    if @participant.save!
      @participant.status = "created"
      ticket = Ticket.find(params[:ticket_id])
      @participation = Participation.create(participant: @participant, ticket: ticket, status: "created")
      flash[:notice] = url
      redirect_to edit_participation_path(@participation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email)
  end
end
