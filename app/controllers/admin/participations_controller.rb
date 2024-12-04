module Admin
  class ParticipationsController < Administrate::ApplicationController
    before_action :set_current_event, only: [:index, :show, :new, :edit]
    layout "admin/application"

    before_action :set_event

    def index
      @resources = @event.participations.includes(:participant, :ticket, :options)
    end

    def set_current_event
      @current_event = Event.find_by(id: session[:current_event])
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end
  end
end
