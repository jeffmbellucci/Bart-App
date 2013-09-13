class RemindersController < ApplicationController
  
  def create
    time_to_run = Time.parse(params[:reminder][:time])
    
    # r = Reminder.new(user: current_user, 
 #                     direction: params[:reminder][:direction], 
 #                     abbr: params[:reminder][:abbr])
 #            
 #    r.perform            
    Delayed::Job.enqueue(Reminder.new(user: current_user, 
                                      direction: params[:reminder][:direction], 
                                      abbr: params[:reminder][:abbr]), 
                                      run_at: time_to_run)
    flash[:success] = "Reminder created"
    redirect_to root_url
  end
  
end

