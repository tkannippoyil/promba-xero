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
      print response
    end
    it { expect(response).to be_success }
    it { print response.body }
    it { print response.methods.sort }
  end
end
