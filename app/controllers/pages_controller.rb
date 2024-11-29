class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def home
  end
end
