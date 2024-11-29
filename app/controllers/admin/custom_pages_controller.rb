module Admin
  class CustomPagesController < Admin::ApplicationController
    def home
      @events = Event.all
      @nextevent = Event.where('date > ?', Time.current).order(date: :asc).first
    end

    def events
      @events = Event.all
    end
  end
end
