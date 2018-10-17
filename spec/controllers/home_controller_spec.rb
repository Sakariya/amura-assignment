# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
    it 'List Home Prospects' do
      get :index
      expect(page).to have_text('Log In With Github')
      expect(response).to have_http_status(200)
    end
    context 'when user signed in' do
      login_user
      it 'should redirect to repositories' do
        get :index
        expect(response).to redirect_to(repositories_path)
      end
    end
  end
end
