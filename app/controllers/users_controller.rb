class UsersController < ApplicationController
  def create
     @user = User.new(params[:user])
     if @user.save
       flash[:success] = "Account created."
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
  
  
   def destroy
     @user = User.find(params[:id])
     @user.delete
     redirect_to root_url
   end
 end

