# frozen_string_literal: true

# common methods of rSpec
module ControllerMacros
  def login_user
    before(:each) do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
    end
  end

  def session_context
    context 'SignIn Success handling' do
      check_session
      it 'should set :notice flash' do
        expect(flash[:notice]).to eq('Logged in successfully')
      end
    end
  end

  def check_session
    it 'should successfully create a session' do
      expect(session).not_to be_empty
    end
    it 'should set current_user to proper user' do
      expect(subject.current_user).to eq(user)
    end
  end

  # rubocop:disable Metrics/AbcSize
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
end
