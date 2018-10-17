# frozen_string_literal: true

# Use for fetch github data
class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    # Call service for get all repositories
    response = GithubApi.new(user: current_user)
    @repositories = response.repositories
  end

  def show
    # Set Date range for commits history
    @since_date = (Time.now - 5.day).beginning_of_day
    @until_date = Time.now
    # Call service for get repository detail
    response = GithubApi.new(user: current_user, repo_name: params[:id])
    @repo = response.repository
    redirect_to repositories_path, alert: 'Repo not found.' if @repo.nil?
  end

  def repo_commits
    @since_date = params[:since_date].to_date.beginning_of_day
    @until_date = params[:until_date].to_date.end_of_day
    # Call service for get repository commits history
    response = GithubApi.new(user: current_user, repo_name: params[:id],
                             since_date: @since_date, until_date: @until_date)
    @commits = response.repo_commits
    render json: @commits
  end
end
