class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    @user = User.find_or_create_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
    )
    @user.update(
      name: auth_hash[:info][:nickname],
      avatar_url: auth_hash[:info][:image],
      token: auth_hash[:credentials][:token],
    )

    return @user
  end
end
