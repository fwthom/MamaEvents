class EventsController < ApplicationController
skip_before_action :authenticate_user!

  def index
    @events = Event.all

  def index

  end

  def show
    @event = Event.find(params[:id])

    @tickets = Ticket.where(event_id: @event.id)
  end



end
