# frozen_string_literal: true

require 'rails_helper'

describe 'routes for Repositories' do
  # test case for repositories routes
  it 'routes /repositories to the Repositories controller' do
    expect(get: '/repositories')
      .to route_to(controller: 'repositories', action: 'index')
  end

  # test case for repositories show routes
  it 'routes /repositories/test to the sessions controller' do
    expect(get: '/repositories/test')
      .to route_to(controller: 'repositories', action: 'show', id: 'test')
  end

  # test case for repositories repo_commits routes
  it 'routes /repositories/test/repo_commits.json to the sessions controller' do
    expect(get: '/repositories/test/repo_commits.json')
      .to route_to(format: 'json', controller: 'repositories',
                   action: 'repo_commits', id: 'test')
  end
end
