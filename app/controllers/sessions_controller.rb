class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    user = User.find_by_phone_number(params[:session][:phone_number])
    if user
      sign_in(user)
      redirect_to user
    else
      flash.now[:error] = 'No user with that phone number'
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end