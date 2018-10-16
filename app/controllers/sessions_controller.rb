# frozen_string_literal: true

# Use for authentication with github
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    redirect_to repositories_path, notice: 'Logged in successfully'
  rescue StandardError => e
    redirect_to root_path, alert: e.message
  end

  def destroy
    reset_session
    redirect_to :root
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
