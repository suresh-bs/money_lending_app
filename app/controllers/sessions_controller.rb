class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(session_params[:user_id])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully'
    redirect_to new_session_path
  end

  private
  def session_params
    params.permit(:email, :password)
  end
end