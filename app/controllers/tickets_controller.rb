class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.create(participant_params)
  end

  def updated

  end

  def delete
    @ticket.destroy
  end

    private

    def participant_params
      params.require(:ticket).permit(:name, :unit_price)
    end

end
