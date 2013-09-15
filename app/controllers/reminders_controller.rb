class RemindersController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy]
  
  def create
    if params[:reminder][:runtime].blank?
      flash[:error] = "Time can't be blank."
      redirect_to root_url
      return
    end
    
    runtime = Time.parse(params[:reminder][:runtime])
    params[:reminder][:user_id] = current_user.id
    params[:reminder][:runtime] = runtime
    
    @reminder = Reminder.new(params[:reminder])
    flash[:success] = "Reminder created." if @reminder.save
    
    Delayed::Job.enqueue(@reminder, run_at: runtime)
    redirect_to root_url 
  end
 
end

