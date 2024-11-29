class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @tickets = Ticket.where(event_id: params["event_id"])
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
  end

  # get
  def new
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
  end

  # Post
  def create
    @event = Event.find(params["event_id"])
    @ticket = Ticket.create(participant_params)
    @ticket.event = @event
    if @ticket.save
      # redirect_to event_path(@event)
      redirect_to event_tickets_path(@event)
    else
      render "tickets/new"
    end

  end

  def updated

  end

  def delete
    @ticket.destroy
  end

    private

    def participant_params
      params.require(:ticket).permit(:name, :unit_price, :description, :present)
    end

end
