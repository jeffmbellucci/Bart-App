class UsersController < ApplicationController
  before_filter :correct_user, :logged_in_user, except: [:create]
  
  def create
     @user = User.new(params[:user])
     if @user.save
       flash[:success] = "Hi #{params[:user][:name]}, your account has been created."
       login(@user)
       redirect_to root_url
     else
       flash[:error] = "Failed account creation."
       redirect_to root_url
     end
   end
  
   def show
     @user = User.find(params[:id])
     render :show
   end
   
   def edit
     @user = User.find(params[:id])
   end
   
   def update
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
        flash[:success] = "You information has been updated."
       redirect_to root_url
     else
       flash[:error] = "Failed account update."
       render :edit
     end
     
   end
  
   def destroy
     @user = User.find(params[:id])
     @user.delete
     redirect_to root_url
   end
 end

