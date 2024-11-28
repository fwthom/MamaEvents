class OptionsController < ApplicationController
  before_action :set_option, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:create, :edit, :update, :destroy]
  def create
    @option = Option.new(option_params)
    if @option.save!
      redirect_to event_path(@event)
    else
      render "options/new",status: :unprocessable_entity
    end
  end

  def edit 
    set_tickets
  end

  def update
    if @option.update(option_params)
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @option.destroy
      redirect_to event_path(@event), notice: 'Une amie supprimée'
    else
      redirect_to options_path, alert: 'Suppression impossible.'
    end
  end

  private
  def option_params
    params.require(:option).permit(:name, :description, :category, :unit_price, ticket_ids: [])
  end

  def set_option
    @option = Option.find(params[:id])
  end

  def set_event
    @event = @option.tickets.first&.event
  end

  def set_tickets
    @tickets = @event.tickets
  end

end
