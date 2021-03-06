# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  # login URL
  get 'auth/github', as: :github_auth

  # Populate list of available repository
  resources :repositories, only: %i[index show] do
    member do
      get 'repo_commits', defaults: { format: 'json' }
    end
  end

  # Manage user session
  match 'auth/:provider/callback', to: 'sessions#create', via: %i[post get]
  delete 'sessions/destroy', as: :logout
end
