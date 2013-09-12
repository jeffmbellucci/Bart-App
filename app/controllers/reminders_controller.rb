
class RemindersController < ApplicationController
  
  def create
    texts = create_station_texts(params[:reminder][:abbr])
    texts.each do |message|
      text = Text.new(current_user.phone_number, message)
      text.send
    end
    flash[:success] = "Reminder created"
    redirect_to root_url
  end
  
end
