require 'spec_helper'
require "rails_helper"

describe Api::V1::CustomersController do

  describe 'index' do
    before do
      customer = Customer.create(
          {
              email: "aabb@hh.de",
              first_name: "test",
              last_name: "1"
          }
      )
      get :index, format: :json
    end
    it { expect(response).to be_success }
    it { expect(response.body).to include('aabb@hh.de') }
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
    it { expect(response).to be_success }
    it {
      expect(JSON.parse(response.body)[0]['email']).to eq(customer[:email])
    }

  end


end
