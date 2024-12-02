module Admin
  class EventsController < Admin::ApplicationController
    before_action :set_events, only: [:index]
    before_action :set_event, only: [:edit, :update, :show, :publication, :publish]
    before_action :set_charity, only: [:show]
    before_action :set_tickets, only: [:show]
    before_action :publication, only: [:index, :show]

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.date = Date.parse(params[:event][:date])
      @event.charity = Charity.first
      @event.status = "brouillon"
      if @event.save!
        redirect_to admin_events_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def index
    end
  
    def show
      @event = Event.find(params[:id])

    end
    def edit 
    end

    def update
      if @event.update(event_params)
        redirect_to admin_event_path(@event)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def publication

    end

    def publish  
      if @event.update(event_params)
        redirect_to publication_admin_event_path(@event), notice: "Statut modifié avec succès."
      else
        render :publication, alert: "Erreur lors du changement de statut de l'événement."
      end

    end
    
    private
  
    def event_params
      params.require(:event).permit(:name, :description, :date, :status, :location, :image)
    end

    def set_events
      @events = Event.all
    end

    def set_event
      @event = Event.find(params[:id])
    end
  
    def set_tickets
      @tickets = @event.tickets
    end

    def set_charity 
      @charity = @event.charity
    end
  end
end
