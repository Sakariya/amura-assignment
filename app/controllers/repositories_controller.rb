class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @repositories = Github.repos.list user: @current_user.name, auto_pagination: true
  end

  def show
  end
end
