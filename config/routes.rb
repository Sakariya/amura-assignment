Rails.application.routes.draw do
  root 'home#index'
  # login URL
  get 'auth/github', as: :github_auth

  # Populate list of available repository
  resources :repositories, only: [:index, :show] do
    member do
      get 'repo_commits'
    end 
  end
  
  # Manage user session
  match 'auth/:provider/callback', to: 'sessions#create', via: [:post, :get]
  delete 'sessions/destroy', as: :logout
end
