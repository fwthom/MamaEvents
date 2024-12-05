module Admin
  class OptionsController < Admin::ApplicationController
    before_action :set_current_event, only: [:index, :show, :new, :edit]
    before_action :set_event, only: [:new, :create, :index, :edit, :update, :destroy]
    before_action :set_option, only: [:edit, :update, :destroy]
    before_action :set_tickets, only: [:new, :edit, :index]

    def new
      if params[:source_id]
        source_option = Option.find(params[:source_id])
        @option = source_option.dup
        @option.ticket_ids = source_option.ticket_ids # Si vous voulez également dupliquer les tickets associés.
      else
        @option = Option.new
      end    
    end
    
    def create
      @option = Option.new(option_params)
      @option.event = @event
      if @option.save
        redirect_to admin_event_options_path(@event)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def index
      @options = @event.options
      @option = Option.new
    end

    def edit
    end

    def update
      if @option.update(option_params)
        redirect_to admin_event_options_path(@event)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @option.destroy
        redirect_to admin_event_options_path(@event), notice: 'Option supprimée'
      else
        redirect_to admin_event_options_path, alert: 'Suppression impossible.'
      end
    end

    private

    def set_current_event
      @current_event = Event.find_by(id: session[:current_event])
    end

    def option_params
      params.require(:option).permit(:name, :description, :category, :unit_price, :emoji, ticket_ids: [])
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
end
