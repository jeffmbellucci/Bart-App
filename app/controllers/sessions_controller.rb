class SessionsController < ApplicationController
  
  def create
    nil.id
    user = User.find_by_phone_number(params[:session][:phone_number])
    if user
      
      sign_in(user)
      flash[success] = "welcome back, #{user.name}"
      redirect_to root_url
    else
      flash.now[:error] = 'No user with that phone number'
      
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end