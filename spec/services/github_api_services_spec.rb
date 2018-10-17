# frozen_string_literal: true

require 'rails_helper'

# Services test cases
RSpec.describe GithubApi do
  let(:user) { FactoryBot.create(:user) }
  let(:repo_name) { 'amura-assignment' }
  let(:since_date) { (Time.now - 5.day).beginning_of_day.strftime('%Y-%m-%d') }
  let(:params) do
    {
      user: user, repo_name: repo_name,
      since_date: since_date, until_date: until_date
    }
  end
  let(:until_date) { Time.now.strftime('%Y-%m-%d') }
  let(:expected_repositories) do
    [
      {
        name: 'amura-assignment', open_issues: 0,
        stargazers_count: 0, forks: 0, private: false
      },
      {
        name: 'burger-builder-react', open_issues: 0,
        stargazers_count: 0, forks: 0, private: false
      },
      {
        name: 'ReactCompleteGuide', open_issues: 0,
        stargazers_count: 0, forks: 0, private: false
      },
      {
        name: 'TestTask', open_issues: 0,
        stargazers_count: 0, forks: 0, private: false
      }
    ]
  end

  let(:expected_repository) do
    {
      name: 'amura-assignment',
      # rubocop:disable LineLength
      description: 'Rails application that connects with users GitHub account and then shows some data about his repositories.'
      # rubocop:enable LineLength
    }
  end

  describe 'GitHub Service' do
    let(:github_api) { GithubApi.new params }
    let(:repositories) { github_api.repositories }
    let(:repository) { github_api.repository }

    # test case for github all repositories list
    it 'get all repositories list' do
      expect(repositories).to eq(expected_repositories)
    end

    # test case for github selected repository details
    it 'get selected repository' do
      expect(repository).to eq(expected_repository)
    end
  end
end
