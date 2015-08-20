module Api
  module V1
    class PrompaOrganisationsController < Api::ApplicationController

      def create
        @prompa_organisation = PrompaOrganisation.create(
            prompa_organisation_params
        )
        render json: @prompa_organisation
      end

      # def update
      #   @connection = PrompaXeroConnection.update(params[:id], params[:prompa_xero_connection])
      #   render json: prompa_xero_connection
      # end

      # def destroy
      #   @connection = PrompaXeroConnection.destroy(params[:id])
      #   render json: prompa_xero_connection
      # end

      def prompa_organisation_params
        params.require(:prompa_organisation).permit(
          :organisation_id,
          :owner_id
          )
      end

    end
  end
end
