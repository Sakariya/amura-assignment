# frozen_string_literal: true

require 'faraday_middleware'
require 'faraday'

# Service for call github API
class GithubApi
  def initialize(params)
    @user = params[:user]
    @repo_name = params[:repo_name]
    @since_date = params[:since_date]
    @until_date = params[:until_date]
    @api_url = 'https://api.github.com/'
  end

  # Call github API for get all repositories
  def repositories
    repo_url = @api_url + 'users/' + @user.name
    @connection = api_connection(repo_url)
    repo_response = @connection.get('repos', access_token: @user.token)
    repo_response.body
  end

  # Call github API for get repository detail by repo_name
  def repository
    repo_url = @api_url + 'repos/' + @user.name
    repo_conn = api_connection(repo_url)
    repo_response = repo_conn.get(@repo_name, access_token: @user.token)
    repo_response.body
  end

  # Call github API for get commits data of particular repo
  def repo_commits
    repo_url = @api_url + 'repos/' + @user.name + '/' + @repo_name
    repo_conn = api_connection(repo_url)
    repo_response = repo_conn.get('commits',
                                  access_token: @user.token,
                                  since: @since_date,
                                  until: @until_date)
    User.format_commits(repo_response.body)
  end

  private

  # Faraday connetion
  def api_connection(api_url)
    Faraday.new(url: api_url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
  end
end
