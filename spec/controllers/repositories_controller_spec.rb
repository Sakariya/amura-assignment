# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  render_views

  # init basic data
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:since_date) { (Time.now - 5.day).beginning_of_day }
  let(:until_date) { Time.now }
  let(:date_range) do
    "#{since_date.strftime('%m/%d/%Y')} - #{until_date.strftime('%m/%d/%Y')}"
  end
  login_user
  current_user

  # test case for list all repositories
  describe 'GET #index' do
    repositories_prospects
    signedin_context(:index, false)
  end

  # test case for show repository detail
  describe 'GET #show' do
    repository_prospects
    unknown_repository_context
    signedin_context(:show, true)
  end

  # test case for show repository commit
  describe 'GET #repo_commits' do
    commits_context
    signedin_context(:repo_commits, true)
  end
end
