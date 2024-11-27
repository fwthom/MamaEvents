class EventsController < ApplicationController

  # before_action :set_event, only: [:show]
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.date = Date.parse(params[:event][:date])
    @event.charity = Charity.first
    if @event.save!
      redirect_to events_path
    else
      render "events/new",status: :unprocessable_entity
    end
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @tickets = Ticket.where(event_id: @event)

    # @restaurant.bookings.where(user: current_user)
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
