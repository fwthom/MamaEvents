module Admin
  class ApplicationController < Administrate::ApplicationController
    helper CloudinaryHelper
    before_action :authenticate_user!
    before_action :set_event_context

    private

    def set_event_context
      if params[:clear_event]
        session.delete(:event_id)
        @current_event = nil
      elsif params[:event_id]
        session[:event_id] = params[:event_id]
        @current_event = Event.find_by(id: session[:event_id])
      else
        @current_event = Event.find_by(id: session[:event_id])
      end
    end


    def authenticate_admin
      # TODO: Add authentication logic here.
    end
  end
end
