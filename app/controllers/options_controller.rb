class OptionsController < ApplicationController
  before_action :set_event, only: [:new, :create, :edit, :index, :update, :destroy]
  before_action :set_option, only: [:edit, :update, :destroy]
  before_action :set_tickets, only: [:new, :edit, :index]
  skip_before_action :authenticate_user!, only: [:show, :index]
  def new
    @option = Option.new
  end
  def create
    @option = Option.new(option_params)
    if @option.save!
      redirect_to event_options_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @options = @event.options.distinct
    @option = Option.new
  end

  def edit
  end

  def update
    if @option.update(option_params)
      redirect_to event_options_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @option.destroy
      redirect_to event_path(@event), notice: 'Option supprimée'
    else
      redirect_to options_path, alert: 'Suppression impossible.'
    end
  end

  private
  def option_params
    params.require(:option).permit(:name, :description, :category, :unit_price, ticket_ids: [])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_option
    @option = Option.find(params[:id])
  end

  def set_tickets
    @tickets = @event.tickets
  end

end
