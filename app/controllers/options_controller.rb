class OptionsController < ApplicationController
  def create
    @option = Option.new(option_params)
    if @option.save!
      redirect_to options_path
      raise!
    else
      render "options/new",status: :unprocessable_entity
    end
  end

  private
  def option_params
    params.require(:option).permit(:name, :description, :category, :unit_price, :ticket_id => [])
  end
end
