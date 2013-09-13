class RemindersController < ApplicationController
  
  def create
    
    self.send_reminder(user: current_user, 
                       direction: params['reminder']['direction'], 
                       abbr: params['reminder']['abbr'])
    flash[:success] = "Reminder created"
    redirect_to root_url
  end
  
end

