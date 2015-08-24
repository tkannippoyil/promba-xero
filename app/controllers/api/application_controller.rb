module Api
  class ApplicationController < ActionController::Base

    protect_from_forgery with: :null_session
    before_action :restrict_access

    private

    def restrict_access
      @setting = Setting.first
      if @setting.api_token != params['api_token']
        render json: {error: 'Invalid Token'}, status: 403
      end
    end


    def get_xero_client
      @setting = Setting.first
      @xero_client = Xeroizer::PublicApplication.new(
          @setting.consumer_key,
          @setting.consumer_secret,
      )

      @xero_connection = PrompaXeroConnection.where(prompa_organisation_id: params['prompa_organisation_id']).first

      if @xero_connection
        @xero_client.authorize_from_access(
            @xero_connection.xero_token,
            @xero_connection.xero_key
        )
      else
        render json: {error: 'Organisation not found.'}
      end
    end


  end
end
