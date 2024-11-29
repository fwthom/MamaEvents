class EventsController < ApplicationController
<<<<<<< HEAD
# before_action :set_event, only: [:show]
skip_before_action :authenticate_user!, only: [:index, :show]
=======
skip_before_action :authenticate_user!
>>>>>>> 2a8b125730502a09d5904cf68329e4f4e4d2fbd9
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

    @event = Event.find(params[:id])

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

<<<<<<< HEAD
  def set_event
    @event = Event.find(params[:id])
  end

=======
>>>>>>> 2a8b125730502a09d5904cf68329e4f4e4d2fbd9
  def set_tickets
    @tickets = @event.tickets
  end
end
