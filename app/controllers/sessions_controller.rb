class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])
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

  def root
    if current_user
      redirect_to current_user.admin? ? admin_loans_path : client_loans_path
    end
  end

  private
  def session_params
    params.permit(:email, :password)
  end
end