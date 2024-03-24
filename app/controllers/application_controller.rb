class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login, if: :current_user

  def after_sign_in_path_for(resource)
    # create_login # you can move this to your sessions_controller#create
    root_path
  end

  private

  def create_login
    device_id = Digest::SHA256.hexdigest("#{request.user_agent}#{request.remote_ip}")
    current_login = current_user.logins.find_or_create_by(device_id: device_id, ip_address: request.remote_ip, user_agent: request.user_agent)
    session[:device_id] = device_id
  end

  # trigger this in your sessions_controller#destroy
  def destroy_login
    current_user.logins.find_by(device_id: session[:device_id])&.destroy
    session.delete(:device_id)
  end

  def require_login
    # after_sign_in_path_for is triggered after require_login
    # return if controller_path == 'devise/sessions' && action_name == 'create'
    return if controller_path == 'users/sessions' && action_name == 'create' # if you are overriding devise sessions_controller

    if Rails.env.test?
      # mock
      current_login = current_user.logins.create(device_id: "test_device_id")
    else
      current_login = current_user.logins.find_by(device_id: session[:device_id])
    end

    if current_login.nil?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Device not recognized."
    end
  end
end
