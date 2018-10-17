# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  describe 'POST #create' do
    before(:each) do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :github)
      post :create, params: { provider: 'github' }
    end
    let(:user) { User.find_by(name: 'poojajk') }
    session_context
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:auth_hash, :github) }
    before(:each) do
      session[:user_id] = user.id
    end
    it 'should clear the session' do
      expect(session).not_to be_empty
      delete :destroy
      expect(session).to be_empty
    end
    it 'redirects to the root page' do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
