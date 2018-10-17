# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # test case for user model
  describe 'User #create' do
    let(:github_info) do
      {
        nickname: 'poojajk',
        image: 'https://avatars0.githubusercontent.com/u/42272976?v=4'
      }
    end
    let(:github_credentials) do
      { token: 'ae87a569e3952ce9bb164f71b0f386d364e957b5' }
    end
    let(:auth_hash) do
      {
        provider: 'github',
        uid: (0...20).map { ('a'..'z').to_a[rand(26)] }.join,
        info: github_info,
        credentials: github_credentials
      }
    end
    it 'find or create user by auth_hash' do
      user = User.find_or_create_from_auth_hash(auth_hash)
      expect(user.name).to eq('poojajk')
    end
  end
end
