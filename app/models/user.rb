# frozen_string_literal: true

# User model for save users data
class User < ApplicationRecord
  # include concerns for format response data
  include FormatJson

  def self.find_or_create_from_auth_hash(auth_hash)
    @user = User.find_or_create_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    ) do |user|
      user.name = auth_hash[:info][:nickname]
      user.avatar_url = auth_hash[:info][:image]
      user.token = auth_hash[:credentials][:token]
      user.save!
    end
    @user
  end
end
