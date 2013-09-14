class RemindersController < ApplicationController
  before_filter :logged_in_user, only: [:create]
  
  def create
    time_to_send = Time.parse(params[:reminder][:time])
    
    Delayed::Job.enqueue(Reminder.new(user: current_user, 
                                      direction: params[:reminder][:direction], 
                                      abbr: params[:reminder][:abbr]), 
                                      run_at: time_to_send)
    flash[:success] = "Reminder created."
    redirect_to root_url
  end
  
end

