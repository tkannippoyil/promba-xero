module Api
  class ApplicationController < ActionController::Base

    protect_from_forgery with: :null_session
    before_action :restrict_access

    private

    def restrict_access
      token_exists = Setting.exists?(api_token: params['api_token'])
      unless token_exists
        render json: {error: 'Invalid Token'}, status: 403
        return
      end
    end

  end
end
