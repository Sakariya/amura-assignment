# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'Success handling' do
      before(:each) do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :github)
        post :create, params: { provider: 'github' }
      end
      let(:user) { User.find_by(name: 'poojajk') }

      it 'should set :notice flash' do
        expect(flash[:notice]).to eq('Logged in successfully')
      end

      it 'should set current_user to proper user' do
        expect(subject.current_user).to eq(user)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:auth_hash, :github) }

    before(:each) do
      session[:user_id] = user.id
    end

    it 'destroys the logged in user session' do
      delete :destroy
      expect(session).to be_empty
    end

    it 'redirects to the root page' do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
