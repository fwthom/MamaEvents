class EventsController < ApplicationController
skip_before_action :authenticate_user!
before_action :set_events, only: [:index]

  def index
    @charity = Charity.find(params[:charity_id])
    @events = @charity.events
  end

  def show
    @event = Event.find(params[:id])
    @charity = @event.charity
  end

  private

  def set_events
    @events = Event.all
  end
end
