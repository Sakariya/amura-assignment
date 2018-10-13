# User model for save users data
class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    @user = User.find_or_create_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )
    @user.update(
      name: auth_hash[:info][:nickname],
      avatar_url: auth_hash[:info][:image],
      token: auth_hash[:credentials][:token]
    )
    return @user
  end

  def self.format_commits_data(response)
    return response.map do |c| 
      {
        committer_date: c['commit']['committer']['date'],
        committer_name: c['commit']['committer']['name'],
        commit_message: c['commit']['message']
      }
    end
  end
end
