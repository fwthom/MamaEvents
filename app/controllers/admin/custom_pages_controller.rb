module Admin
  class CustomPagesController < Admin::ApplicationController
    def home
      @events = Event.all
    end

    def events
      @events = Event.all
    end
  end
end