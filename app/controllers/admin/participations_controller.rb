module Admin
  class ParticipationsController < Administrate::ApplicationController
    before_action :set_event

    private

    def set_event
      @event = Event.find(params[:event_id])
    end
  end
end
