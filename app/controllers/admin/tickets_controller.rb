module Admin
  class TicketsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
    # 
    before_action :set_event, only: [:new, :create, :index, :edit, :update, :destroy]
    before_action :set_ticket, only:[:edit, :update, :destroy]
    before_action :set_tickets, only:[:index]
    def index
      @ticket = Ticket.new
    end

    def new
      @ticket = Ticket.new
    end
  
    def create
      @ticket = Ticket.create(ticket_params)
      @ticket.event = @event
      if @ticket.save
        redirect_to admin_event_tickets_path(@event)
      else
        render "/admin/tickets/new"
      end
    end

    def edit 
    end

    def update
      if @ticket.update(ticket_params)
        redirect_to admin_event_tickets_path(@event)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @ticket.destroy
    end
  
    private

    def ticket_params
      params.require(:ticket).permit(:name, :unit_price, :description, :present)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_tickets
      @tickets = @event.tickets
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
  end
end
