class SessionsController < ApplicationController
  
  def create 
    user = User.find_by_phone_number(params[:session][:phone_number])
    if user
      login(user)
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to root_url
    else
      flash[:error] = 'No user with that phone number'
      redirect_to root_url
    end
  end
  
  def destroy
     flash[:success] = "Successfully logged out"
    logout
    redirect_to root_url
  end
end