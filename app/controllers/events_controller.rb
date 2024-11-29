class EventsController < ApplicationController
skip_before_action :authenticate_user!
before_action :set_events, only: [:index]
before_action :set_charity, only: [:index, :show]

  def index
    @events = Event.where(charity_id: @charity)


  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def set_events
    @events = Event.all
  end

  def set_charity
    @charity = Charity.first
  end
end
