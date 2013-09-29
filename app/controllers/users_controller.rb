class UsersController < ApplicationController
  before_filter :correct_user, :logged_in_user, except: [:create]
  
  def create
    unless params[:password] == ENV["SIGNUP_PASSWORD"]
      flash[:error] = ["Incorrect activation code. Click contact for information."]
      redirect_to root_url
      return
    end
      
     params[:user][:email] = params[:user][:email].downcase;
     @user = User.new(params[:user])
     if @user.save
       flash[:success] = ["Hi #{params[:user][:name]}, your account has been created."]
       login(@user)
       redirect_to root_url
     else
       flash[:error] = @user.errors.full_messages
       redirect_to root_url
     end
   end
  
   def update
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
        flash[:success] = ["You're information has been updated."]
       redirect_to root_url
     else
       flash[:error] = @user.errors.full_messages
       redirect_to root_url
     end
     
   end
  
   def destroy
     @user = User.find(params[:id])
     @user.delete
     @user.reminders.each do |reminder| 
       reminder.destroy 
       reminder.delete_delayed_job
     end
     render json: @user
   end
 end

