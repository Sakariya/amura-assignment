# frozen_string_literal: true

require 'rails_helper'

describe 'routes for Sessions' do
  it 'routes /auth/github/callback to the sessions controller' do
    expect(post: '/auth/github/callback')
      .to route_to(controller: 'sessions', action: 'create', provider: 'github')
  end
  it 'routes /sessions/destroy to the sessions controller' do
    expect(delete: '/sessions/destroy')
      .to route_to(controller: 'sessions', action: 'destroy')
  end
end
