# frozen_string_literal: true

# Format JSON data
module FormatJson
  extend ActiveSupport::Concern

  # self methods of models
  module ClassMethods
    def format_commits(response)
      response.map do |c|
        {
          committer_date: c['commit']['committer']['date'],
          committer_name: c['commit']['committer']['name'],
          commit_message: c['commit']['message']
        }
      end
    end
  end
end
