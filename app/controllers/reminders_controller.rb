class RemindersController < ApplicationController
  
  def create
    message = params[:reminder][:abbr]
    text = Texter.new(current_user.phone_number, message)
    text.send
    flash[:success] = "Reminder created"
    redirect_to root_url
  end
  
end
