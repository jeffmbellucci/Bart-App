class RemindersController < ApplicationController
  before_filter :logged_in_user, only: [:index, :create, :destroy]
  
  def index
    render json: current_user.reminders
  end
  
  def create
    unless params[:reminder][:date].blank?
      begin 
        Date.parse(params[:reminder][:date])
      rescue
        render json: "Date is invalid. Format must be YYYY-MM-DD."
        return
      end
    end
    
    if params[:reminder][:runtime].blank?
      render json: "Time cant be blank."
      return
    end
    
    if current_user.reminders.count == 10
      render json: "You can only have 10 reminders."
      return
    end
    
    runtime = Time.parse(params[:reminder][:runtime]) if params[:reminder][:date].blank?
    date_time = params[:reminder][:date] + " " + params[:reminder][:runtime]
    runtime = Time.parse(date_time) + 7.hours  #adjustment for timezone
    @station = Station.find_by_abbr(params[:reminder][:station_abbr])
    
    params[:reminder][:station_name] = @station.name
    params[:reminder][:user_id] = current_user.id
    params[:reminder][:runtime] = runtime 
    params[:reminder][:completed] = false
    params[:reminder].delete(:date)
    
    @reminder = Reminder.new(params[:reminder])
    render :json => @reminder, :status => 422 unless @reminder.save
    
    Delayed::Job.enqueue(@reminder, run_at: runtime) 
    @reminder.job_id = Delayed::Job.last.id
    @reminder.save

    render json: @reminder
  end
 
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.delete_delayed_job
    @reminder.destroy

    render json: [current_user.reminders.count, @reminder.id]
  end
end

