module Admin
  class PaymentsController < Admin::ApplicationController
    def valid_action?(name, resource = resource_class)
      %w[edit destroy new].exclude?(name.to_s) && super
    end
  end
end
