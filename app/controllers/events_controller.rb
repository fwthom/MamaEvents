class EventsController < ApplicationController
skip_before_action :authenticate_user!
before_action :set_events, only: [:index]

  def index
<<<<<<< HEAD
    @charity = Charity.find(params[:charity_id])
    @events = @charity.events
=======

    @charity = Charity.find(params[:charity_id])
    @events = Event.where(charity_id: @charity)


>>>>>>> 6201b1484384f49ad183a9be601c80dd926eb70e
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
