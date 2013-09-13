class RemindersController < ApplicationController
  
  def create
    #nil.id
    send_reminder(params[:reminder][:abbr], current_user)
    flash[:success] = "Reminder created"
    redirect_to root_url
  end
  
end

# def create_texts(station_abbreviation, phone_number)
#    yadda yadda
# end
#
#
