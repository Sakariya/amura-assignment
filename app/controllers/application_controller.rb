# frozen_string_literal: true

# Application page controller
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user
    # rubocop:disable LineLength
    redirect_to :root, alert: 'Please login with github account.' unless logged_in?
    # rubocop:enable LineLength
  end
end
