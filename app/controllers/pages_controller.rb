class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @charity = Charity.first
    @nextevent = Event.publies.where('date > ?', Time.current).order(date: :asc).first
  end


end
