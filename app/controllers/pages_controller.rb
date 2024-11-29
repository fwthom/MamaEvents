class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @charity = Charity.first
  end


end
