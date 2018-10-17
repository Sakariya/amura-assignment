# frozen_string_literal: true

FactoryBot.define do
  # user row
  factory :user do
    id 1
    name 'poojajk'
    provider 'github'
    avatar_url 'https://avatars0.githubusercontent.com/u/42272976?v=4'
    token 'ae87a569e3952ce9bb164f71b0f386d364e957b5'
  end
end
