class UsersController < ApplicationController
  def new
    render :new
  end

  def show
  end

  def create
    # user = User.new(username: 'louis', password: 'password')
    user = User.new(username: user_params[:username], password: user_params[:password])
    
    if user.save
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy

  end
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end
