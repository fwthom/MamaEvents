module Admin
  class EventsController < Admin::ApplicationController
    before_action :set_events, only: [:index]
    before_action :set_event, only: [:edit, :update, :show, :publication, :publish]
    before_action :set_charity, only: [:show]
    before_action :set_tickets, only: [:show]

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
      if @event.status == "brouillon"
        @can_publish = true
      else
        @can_publish = false
      end
      if @event.date < Time.current
        @event.update(status: "terminé") unless @event.status == "terminé"
      end
    end
    def publish
      @event = Event.find(params[:id])
  
      if @event.update(status: "publié")
        redirect_to publication_admin_event_path(@event), notice: "L'événement a été publié avec succès."
      else
        render :publication, alert: "Erreur lors de la publication de l'événement."
      end

    end
    private
  
    def event_params
      params.require(:event).permit(:name, :description, :date, :status, :location)
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
