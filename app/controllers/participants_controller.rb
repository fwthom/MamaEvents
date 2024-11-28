class ParticipantsController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])

  end

  def new
    @participant = Participant.new
    @event = Event.find(params[:event_id])
    @charity = Charity.find(params[:charity_id])
  end

  def create
    @participant = Participant.new(participant_params)
    @event = Event.find(params[:event_id])
    @participant.event = @event
    if @participant.save!
      redirect_to @event, notice: 'participant was successfully created.'
    else
      raise
      render :new
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update(participant_params)
      redirect_to @participant, notice: 'Le participant a été mise à jour avec succès.'
    else
      render :edit
    end
  end



  def destroy
    @participant = Participant.find(params[:id])
      if @participant.destroy
        redirect_to dashboard_path, notice: 'Participant supprimé'
      else
        redirect_to dashboard_path, alert: 'Suppression impossible.'
      end
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email)
  end
end
