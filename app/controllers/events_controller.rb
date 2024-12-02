class EventsController < ApplicationController
skip_before_action :authenticate_user!

  def index
    @events = Event.publies

  end

  def show
    # @token = Participant.token
    @event = Event.find(params[:id])

    @tickets = Ticket.where(event_id: @event.id)
  end



end
