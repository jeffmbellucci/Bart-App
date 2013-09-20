class RemindersController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy]
  
  def create
    if params[:reminder][:runtime].blank?
      #flash[:error] = "Time can't be blank."
      render json: "Time cant be blank."
      # redirect_to root_url
      return
    end
    
    runtime = Time.parse(params[:reminder][:runtime]) if params[:reminder][:date].blank?
    date_time = params[:reminder][:date] + " " + params[:reminder][:runtime]
    runtime = Time.parse(date_time)
 
    params[:reminder][:user_id] = current_user.id
    params[:reminder][:runtime] = runtime
    params[:reminder][:completed] = false
    params[:reminder].delete(:date)
    
    @reminder = Reminder.new(params[:reminder])
    flash[:success] = "Reminder created." if @reminder.save
    
    Delayed::Job.enqueue(@reminder, run_at: runtime)
    @reminder.job_id = Delayed::Job.last.id
    @reminder.save
   
    respond_to do |format|
      format.json { render json: @reminder }
    end
  end
 
  def destroy
    @reminder = Reminder.find(params[:id])
    Delayed::Job.find(@reminder.job_id).destroy unless Delayed::Job.find_by_id(@reminder.job_id).nil?
    @reminder.destroy
    respond_to do |format|
      format.json { render json: current_user.reminders.count }
    end
  end
end

