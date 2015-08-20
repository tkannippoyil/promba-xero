module Api
  module V1
    class XeroSessionController < Api::ApplicationController

      before_filter :get_xero_client

      public

      def index
        @xero_client.authorize_from_request(
            session[:request_token],
            session[:request_secret],
            :oauth_verifier => params[:oauth_verifier]
        )

        session[:xero_auth] = {
            :access_token => @xero_client.access_token.token,
            :access_key => @xero_client.access_token.secret
        }

        session[:request_token] = nil
        session[:request_secret] = nil

        redirect_to customers_url
      end

      def new
        logger.info(url_for(action: 'create'))
        request_token = @xero_client.request_token(
            :oauth_callback => url_for(action: 'create')
        )
        session[:request_token] = request_token.token
        session[:request_secret] = request_token.secret

        redirect_to request_token.authorize_url
      end

      def create
        @xero_client.authorize_from_request(
            session[:request_token],
            session[:request_secret],
            :oauth_verifier => params[:oauth_verifier] )

        session[:xero_auth] = {
            :access_token => @xero_client.access_token.token,
            :access_key => @xero_client.access_token.secret
        }

        session[:request_token] = nil
        session[:request_secret] = nil
      end

      def destroy
        session.data.delete(:xero_auth)
      end

      private

      def get_xero_client
        logger.info(XERO_CONFIG['consumer_key'])
        @xero_client = Xeroizer::PublicApplication.new(
            XERO_CONFIG['consumer_key'],
            XERO_CONFIG['consumer_secret'],
        )

        logger.info(@xero_client)
        # Add AccessToken if authorised previously.
        if session[:xero_auth]
          @xero_client.authorize_from_access(
              session[:xero_auth][:access_token],
              session[:xero_auth][:access_key]
          )
        end
      end
    end
  end
end
