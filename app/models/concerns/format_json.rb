# frozen_string_literal: true

# Format JSON data
module FormatJson
  extend ActiveSupport::Concern

  # self methods of models
  module ClassMethods
    # map required commits data
    def format_commits(response)
      response.map do |c|
        {
          committer_date: c['commit']['committer']['date'],
          committer_name: c['commit']['committer']['name'],
          commit_message: c['commit']['message']
        }
      end
    end

    # map required repositories data
    def format_repositories(response)
      response.map do |r|
        {
          name: r['name'],
          open_issues: r['open_issues'],
          stargazers_count: r['stargazers_count'],
          forks: r['forks'],
          private: r['private']
        }
      end
    end

    # get required repository data
    def format_repository(response)
      {
        name: response['name'],
        description: response['description']
      }
    end
  end
end
