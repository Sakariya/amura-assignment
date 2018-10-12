class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @repositories = Github.repos.list user: @current_user.name, auto_pagination: true, type: :all
  end

  def show
    if params[:date].present?
      url = "https://api.github.com/repos/#{@current_user.name}/#{params[:id]}/commits?access_token=#{@current_user.token}&since=#{params[:date]}"
      response = RestClient.get(url)
      @commits = JSON.parse(response)
    else
      @commits = Github.repos.commits.all @current_user.name, params[:id]
    end

    respond_to do |format|
      format.json { render json: @commits }
      format.html { @commits }
    end
  end
end
