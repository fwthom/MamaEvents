class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @charity = Charity.find(params[:id])
    @events = Event.where(charity_id: params[:id])
  end
  def new
    @charity = Charity.new
  end
  def create
    @charity = Event.new(event_params)
    if @charity.save!
      redirect_to events_path
    else
      render "charity/new",status: :unprocessable_entity
    end
  end

end
