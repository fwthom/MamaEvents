class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper CloudinaryHelper
end
