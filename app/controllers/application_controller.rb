class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  helper_method :current_user

  private

  def authenticate_user!
    if current_user.nil?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
