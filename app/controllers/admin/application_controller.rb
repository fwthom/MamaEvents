module Admin
  class ApplicationController < Administrate::ApplicationController
    helper CloudinaryHelper
    before_action :authenticate_user!

    private


    def authenticate_admin
      # TODO: Add authentication logic here.
    end
  end
end
