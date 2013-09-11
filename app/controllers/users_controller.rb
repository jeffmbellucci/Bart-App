class UsersController < ApplicationController
  def new
     @user = User.new
     render :new
   end
  
   def create
     @user = User.new(params[:user])
     if @user.save
       flash[:success] = "Account created."
       login(@user)
       redirect_to root_url
     else
       render :new
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
end
