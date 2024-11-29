class OptionsController < ApplicationController
  before_action :set_event, only: [:index]
  before_action :set_tickets, only: [:index]
  
  
  def index
    @options = @event.options.distinct
    @option = Option.new
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_tickets
    @tickets = @event.tickets
  end

end
