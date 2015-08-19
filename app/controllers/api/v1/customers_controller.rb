module Api
  module V1
    class CustomersController < ApplicationController
      #http_basic_authenticate_with name: "admin", password: "secret"
      before_filter :restrict_access 
      class Customer < ::Customer
        # Note: this does not take into consideration the create/update actions for changing released_on
        def as_json(options = {})
          super.merge(released_on: "released_at.to_date")
        end
      end


      def index
        @customers = Customer.all
        render json: @customers
      end

      def show
        @customer = Customer.find(params[:id])
        render json: @customer
      end

      def create
        @customer = Customer.create(params[:customer])
        render json: @customer
      end

      def update
        @customer = Customer.update(params[:id], params[:customer])
        render json: @customer
      end

      def destroy
        @customer = Customer.destroy(params[:id])
        render json: @customer
      end
    private
    
      # def restrict_access
      #   api_key = ApiKey.find_by_access_token(params[:access_token])
      #   head :unauthorized unless api_key
      # end
    
      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end
    end
  end
end
