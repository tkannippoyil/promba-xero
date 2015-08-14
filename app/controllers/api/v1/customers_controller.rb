module Api
  module V1
    class CustomersController < ApplicationController
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


    end
  end
end
