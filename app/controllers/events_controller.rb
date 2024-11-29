class EventsController < ApplicationController
# before_action :set_event, only: [:show]
skip_before_action :authenticate_user!, only: [:index, :show]
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.date = Date.parse(params[:event][:date])
    @event.charity = Charity.first
    if @event.save!
      # redirect_to charity_event_path
      redirect_to events_path
    else
      render "events/new", status: :unprocessable_entity
    end
  end

  def index
    @events = Event.all
  end

  def show
    @charity = @event.charity
    set_tickets
    @option = Option.new
  end

  def details
    @event = Event.find(params[:event_id])
  end

  def tickets
    set_tickets
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_tickets
    @tickets = @event.tickets
  end
end
