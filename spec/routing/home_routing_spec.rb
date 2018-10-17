# frozen_string_literal: true

require 'rails_helper'

describe 'routes for Root path' do
  # test case for home routes
  it 'routes / to the Home controller' do
    expect(get: '/')
      .to route_to(controller: 'home', action: 'index')
  end
end
