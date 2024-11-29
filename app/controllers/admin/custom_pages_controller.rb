module Admin
  class CustomPagesController < Admin::ApplicationController
    def home
      @events = Event.all
    end

    def events
      @events = Event.all
    end

    def option_index
    end

    def option_edit
    end

    def option_new
    end
  end
end
