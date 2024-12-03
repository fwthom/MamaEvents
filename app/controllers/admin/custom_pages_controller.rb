module Admin
  class CustomPagesController < Admin::ApplicationController
    def home
      @events = Event.all
      @nextevent = Event.where('date > ?', Time.current).order(date: :asc).first
      @charity = Charity.first
      @participations = Participation.all
      @tickets = @nextevent.tickets
    end

    def events
      @events = Event.all
    end

    def data_extract
      @event = Event.find(params[:event_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_events_path, alert: "Event not found"
    end

    def clear_event
      session[:event_id] = nil
      redirect_to admin_root_path
    end

    private

    def generate_csv(participants)
      CSV.generate(headers: true) do |csv|
        csv << ["Name", "Email", "Registered On"]
        participants.each do |participant|
          csv << [participant.name, participant.email, participant.created_at.strftime("%d %b %Y")]
        end
      end
    end
  end
end
