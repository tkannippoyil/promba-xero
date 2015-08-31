require 'prompa_api'
module Api
  module V1
    class PrompaOrganisationsController < Api::ApplicationController
      before_action :get_xero_client, only: [:index]

      def new
        @prompa_organisation = PrompaOrganisation.find_or_initialize_by(
               organisation_id: params[:organisation_id]
        )
        @prompa_organisation.owner_id = params[:owner_id]
        @prompa_organisation.token = params[:token]
        @prompa_organisation.expired = false

        if @prompa_organisation.save
          redirect_to api_xero_session_index_path(
              api_token: params[:api_token],
              prompa_organisation_id: @prompa_organisation.id
          )
        else
          render json: @prompa_organisation
        end

      end

      def show
        @prompa_organisation = PrompaOrganisation.find_by(
               organisation_id: params[:id]
        )
        if @prompa_organisation
          render json: @prompa_organisation,
                 include: {
                     prompa_xero_connection: {
                         only: [
                             :xero_token,
                             :xero_key,
                             :expired,
                         ]
                     },
                 },
                except: [:created_at, :updated_at]
        else
          render json: {error: "Not found"}
        end
      end

      def index
        begin
          @data = @xero_client.Contact.all
          @org = PrompaOrganisation.last
          render json: @data
        rescue Xeroizer::OAuth::TokenExpired
          render json:  {error: 'Xero token expired'}
        end

      end

    end
  end
end
