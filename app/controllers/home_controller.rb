# frozen_string_literal: true

# Home page controller
class HomeController < ApplicationController
  def index
    redirect_to repositories_path if logged_in?
  end
end
