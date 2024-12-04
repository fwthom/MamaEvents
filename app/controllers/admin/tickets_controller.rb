module Admin
  class TicketsController < Admin::ApplicationController
    before_action :set_current_event, only: [:index, :show, :new, :edit]
    before_action :set_event, only: [:new, :create, :index, :edit, :update, :destroy]
    before_action :set_ticket, only:[:edit, :update, :destroy]
    before_action :set_tickets, only:[:index]
    def index
      @ticket = Ticket.new
    end

    def new
      if @event.status == "terminé"
        redirect_to admin_event_tickets_path(@event), alert: "Impossible de créer un ticket car l'événement est terminé."
        return
      end
      @ticket = Ticket.new
    end

    def create
      @ticket = Ticket.create(ticket_params)
      @ticket.event = @event
      if @ticket.save
        redirect_to admin_event_tickets_path(@event)
      else
        render "/admin/tickets/new"
      end
    end

    def edit
      if @event.status == "terminé"
        redirect_to admin_event_tickets_path(@event), alert: "Impossible de modifier un ticket car l'événement est terminé."
        return
      end
    end

    def update
      if @ticket.update(ticket_params)
        redirect_to admin_event_tickets_path(@event)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @ticket.destroy
        redirect_to admin_event_tickets_path(@event), notice: 'Ticket supprimé avec succès.'
      else
        redirect_to admin_event_tickets_path(@event), alert: 'Suppression impossible'
      end
    end

    private

    def set_current_event
      @current_event = Event.find_by(id: session[:current_event])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :unit_price, :description, :remote)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_tickets
      @tickets = @event.tickets
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
  end
end
