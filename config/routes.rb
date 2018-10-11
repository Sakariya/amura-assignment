Rails.application.routes.draw do
  root 'home#index'
  # login URL
  get 'auth/github', as: :github_auth
  # Populate list of available repository
  get 'repository', to: "home#repository", as: :github_repository
  # Manage user session
  match 'auth/:provider/callback', to: 'sessions#create', via: [:post, :get]
  delete 'sessions/destroy', as: :logout
end
