class LoginsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logins = current_user.logins
  end

  def destroy
    @login = current_user.logins.find(params[:id])
    @login.destroy!
    redirect_to logins_url, notice: "Device disconnected."
  end
end
