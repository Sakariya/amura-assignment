# frozen_string_literal: true

FactoryBot.define do
  # user row
  factory :user do
    id 1
    name 'poojajk'
    provider 'github'
    avatar_url 'https://avatars0.githubusercontent.com/u/42272976?v=4'
    token sequence(:uid)
  end
end
