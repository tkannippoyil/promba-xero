require 'spec_helper'
require "rails_helper"

describe Api::V1::CustomersController do

  describe 'index' do
    customer =         {
            email: "aabb@hh.de",
            first_name: "test",
            last_name: "1"
        }
    before do
      Customer.create(customer)
      get :index, format: :json
    end
    it do
      expect(response).to be_success
      expect(response.body).to include(customer[:email])
    end
  end

  describe 'show' do
    customer = {
        email: "aabb@hh.de",
        first_name: "test",
        last_name: "2"
    }
    before do
      Customer.create(customer)
      get :index, format: :json
    end
    it do
      expect(response).to be_success
      expect(JSON.parse(response.body)[0]['email']).to eq(customer[:email])
    end

  end


end
