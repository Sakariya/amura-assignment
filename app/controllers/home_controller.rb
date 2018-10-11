class HomeController < ApplicationController
  before_action :authenticate_user, :only => :repository

  def index
  end

  def repository
  end
end
