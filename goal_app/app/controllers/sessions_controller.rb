class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login(user)
    else
      redirect_to new_session_url
    end
    redirect_to user_url(user)
  end

  def destroy
    # 
    logout!
    redirect_to new_session_url
  end
end
