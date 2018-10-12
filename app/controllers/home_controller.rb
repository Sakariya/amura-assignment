class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to repositories_path
    end
  end
end
