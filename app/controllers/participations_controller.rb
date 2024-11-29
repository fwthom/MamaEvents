class ParticipationsController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @participation = Participation.new

  end

  def create
    @participation = Participation.create(participation_params)
    @participation.ticket_id = id
    @participation.participant = @participant
    @participation.payment_id = "payment_id"
    if @participation.save
      redirect_to @event, notice: 'Participation enregistrée attente paiment'
    else
      render :new
    end
  end

  def show
    @participation = Participation.all
  end

  private

  def participation_params
    params.require(:participation).permit(:ticket_id, :status, :participant_id, :payment_id)
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email)
  end

end
