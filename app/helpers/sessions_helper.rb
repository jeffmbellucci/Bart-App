module SessionsHelper

  def login(user)
    cookies.permanent[:session_token] = user.create_session_token
    self.current_user = user
  end
  
  def logout
    cookies.delete(:session_token)
     self.current_user = nil
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(cookies[:session_token])
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def logged_in?
    !!current_user
  end
  
  def signed_in_user
    if !logged_in?
      flash[:notice] = "Please sign in."
      redirect_to new_sessions_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:notice] = "You are not allowed to do that."
      redirect_to new_sessions_url unless logged_in?
      redirect_to root_url if logged_in?
    end
  end
  
end
