# frozen_string_literal: true

# common methods of rSpec
module ControllerMacros
  # Logged in user to app
  def login_user
    before(:each) do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
    end
  end

  # Check if signed in successfully
  def session_context
    context 'SignIn Success handling' do
      check_session
      it 'should set :notice flash' do
        expect(flash[:notice]).to eq('Logged in successfully')
      end
    end
  end

  # Check session value present
  def check_session
    it 'should successfully create a session' do
      expect(session).not_to be_empty
    end
    it 'should set current_user to proper user' do
      expect(subject.current_user).to eq(user)
    end
  end

  # if user is not signed in access repositories page
  def signedin_context(action, exatra_params)
    context 'when user is signed out' do
      logout_user
      redirects_to_root(action, exatra_params)
    end
  end

  # Delete session
  def logout_user
    before do
      session[:user_id] = nil
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(nil)
    end
  end

  # Redirect user to root page if not signed in
  def redirects_to_root(action, exatra_params)
    it 'redirects to the root page if user is not authenticated' do
      if exatra_params
        get action, params: { id: 'amura-assignment' }
      else
        get action
      end
      expect(response).to redirect_to(root_url)
      expect(flash[:alert]).to eq('Please login with github account.')
    end
  end

  # fetch current user
  def current_user
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  # rubocop:disable Metrics/AbcSize
  # view prospects of repositories
  def repositories_prospects
    it 'List Repositories Prospects' do
      get :index
      expect(page).to have_text('Repositories')
      expect(page).to have_text('Name')
      expect(page).to have_text('Open issues')
      expect(page).to have_text('Stars')
      expect(page).to have_text('Forks')
      expect(page).to have_text('Type')
      expect(response).to have_http_status(200)
    end
  end
  # rubocop:enable Metrics/AbcSize

  # view prospects of repository
  def repository_prospects
    it 'List Repository Prospects' do
      get :show, params: { id: 'amura-assignment' }
      expect(page).to have_text('amura-assignment')
      expect(page).to have_link('Repositories')
      expect(response).to have_http_status(200)
    end
    mate_date_range
  end

  # Match date range for d3 chart
  def mate_date_range
    it 'should match since and until' do
      get :show, params: { id: 'amura-assignment' }
      expect(page).to have_selector("input[value=\'#{date_range}\']")
    end
  end

  # If check for unknown repository
  def unknown_repository_context
    it 'redirects to the repositories if repository is not found' do
      get :show, params: { id: 'amura-assignment234' }
      expect(response).to redirect_to(repositories_path)
      expect(flash[:alert]).to eq('Repo not found.')
    end
  end

  # Repository commits data should request with json
  def commits_context
    it 'List Repository Prospects' do
      get :repo_commits, params: { id: 'amura-assignment',
                                   since_date: since_date,
                                   until_date: until_date }
      expect(response).to have_http_status(200)
      expect(response.headers).to include('Content-Type' =>
        'application/json; charset=utf-8')
    end
  end
end
