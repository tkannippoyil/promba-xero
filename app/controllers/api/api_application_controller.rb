class ApiApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :restrict_access

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      # ApiKey.exists?(access_token: token)
      true
    end
  end

end
