class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_or_create_user(auth_hash)
    session[:user_id] = @user.id
    redirect_to github_repository_path
  end

  def destroy
    reset_session
    redirect_to :root
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
