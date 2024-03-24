class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:admin]

  def index
  end

  def admin
  end
end
