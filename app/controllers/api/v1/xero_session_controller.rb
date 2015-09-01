module Api
  module V1
    class XeroSessionController < Api::ApplicationController

      before_action :set_xero_client



      public

      def index
        request_token = @xero_client.request_token(
            oauth_callback: new_api_xero_session_url(params),
            # scope: 'payroll.employees'
        )
        session[:request_token] = request_token.token
        session[:request_secret] = request_token.secret

        redirect_to request_token.authorize_url + "&scope=payroll.employees"
      end

      def new
        begin
          @xero_client.authorize_from_request(
                session[:request_token],
              session[:request_secret],
              :oauth_verifier => params[:oauth_verifier]
          )

          @prompa_xero_connection= PrompaXeroConnection
                                          .find_or_initialize_by(
              prompa_organisation_id: params[:prompa_organisation_id]
          )

          @prompa_xero_connection.xero_token = @xero_client.access_token.token
          @prompa_xero_connection.xero_key = @xero_client.access_token.secret
          @prompa_xero_connection.expired = false


          @xero_organisation = XeroOrganisation.find_or_initialize_by(
              organisation_id: params[:org]
          )

          # @xero_organisation.owner_id = @xero_client.User.first.id
          @xero_organisation.organisation_id = params[:org]
          @xero_organisation.save!

          @prompa_xero_connection.xero_organisation = @xero_organisation
          @prompa_xero_connection.save!



          session[:request_token] = nil
          session[:request_secret] = nil

          render json: {success: 'Connected to Xero'}
        rescue Exception => error
          session[:xero_auth] = nil
          render json: {error: 'Not able to connect with Xero: ' + error.to_s}
        end
      end

      def destroy
        session.data.delete(:xero_auth)
      end


      def set_xero_client
        @xero_client = Xeroizer::PublicApplication.new(
            @setting.consumer_key,
            @setting.consumer_secret,
        )
      end

    end
  end
end
