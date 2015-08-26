module Api
  module V1
    class PrompaOrganisationsController < Api::ApplicationController
      require 'prompa_api'
      before_action :get_xero_client, only: [:index]

      def new
        @prompa_organisation = PrompaOrganisation.find_or_initialize_by(
               organisation_id: params['organisation_id']
        )
        @prompa_organisation.owner_id = params['owner_id']
        @prompa_organisation.token = params['token']

        if @prompa_organisation.save
          redirect_to api_xero_session_index_path(
              api_token: params['api_token'],
              prompa_organisation_id: @prompa_organisation.id
          )
        else
          render json: @prompa_organisation
        end

      end

      def index
        begin
          @data = @xero_client.Contact.all
          @org = PrompaOrganisation.last
          @prompa_data = PrompaApi.new(@setting.prompa_url, @org.token).get_users
          render json: @prompa_data
        rescue Xeroizer::OAuth::TokenExpired
          render json:  {error: 'Xero token expired'}
        end

      end

    end
  end
end
