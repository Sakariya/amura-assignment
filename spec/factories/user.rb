# frozen_string_literal: true

FactoryBot.define do
  # user row
  factory :user do
    id 1
    name 'poojajk'
    provider 'github'
    avatar_url 'https://avatars0.githubusercontent.com/u/42272976?v=4'
    token 'e936805c1a65a94aa0f5eb64aea0a9a917c6b3f7'
  end
end
