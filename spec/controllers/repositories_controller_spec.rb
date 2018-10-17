# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  login_user

  describe 'GET #index' do
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
    context 'when user is signed out' do
      before do
        session[:user_id] = nil
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(nil)
      end
      it 'redirects to the root page if user is not authenticated' do
        get :index
        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq('Please login with github account.')
      end
    end
    repositories_prospects
  end
end
