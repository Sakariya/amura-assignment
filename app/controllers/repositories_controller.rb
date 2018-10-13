require 'faraday_middleware'
require 'faraday'

class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @repositories = Github.repos.list user: @current_user.name, auto_pagination: true, type: :all
  end

  def show
    @since_date = (Time.now - 5.day).beginning_of_day
    @until_date = Time.now

    # Call githhub API for get selected repo
    repo_url = 'https://api.github.com/repos/' + @current_user.name
    repo_conn = Faraday.new(url: repo_url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
    repo_response = repo_conn.get(params[:id], access_token: @current_user.token)
    @repo = repo_response.body
  end

  def repo_commits
    @since_date = params[:since_date].present? ? params[:since_date].to_date.beginning_of_day : (Time.now - 5.day).beginning_of_day
    @until_date = params[:until_date].present? ? params[:until_date].to_date.end_of_day : Time.now
    # Call github API for get commits between since and untill date.
    url = 'https://api.github.com/repos/' + @current_user.name + '/' + params[:id]
    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
    response = conn.get('commits', access_token: @current_user.token, since: @since_date, until: @until_date)
    @commits = User.format_commits_data(response.body)
    render json: @commits
  end
  
end
