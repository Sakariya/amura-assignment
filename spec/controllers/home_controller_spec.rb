# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  # test case for home page
  describe 'GET #index' do
    # test case for sucess response
    it 'List Home Prospects' do
      get :index
      expect(page).to have_link('Log In With Github')
      expect(response).to have_http_status(200)
    end
    # test case for if user signed in
    context 'when user signed in' do
      login_user
      it 'should redirect to repositories' do
        get :index
        expect(response).to redirect_to(repositories_path)
      end
    end
  end
end
