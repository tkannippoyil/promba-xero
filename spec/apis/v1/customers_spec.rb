require 'spec_helper'
require "rails_helper"

describe Api::V1::CustomersController do

  describe 'index' do
    customer = nil
    before do
      customer = create(:customer)
      get :index, format: :json
    end
    it do
      users = JSON.parse(response.body)
      expect(response).to be_success
      expect(users[0]['email']).to eq(customer[:email])
    end
  end

  describe 'show' do
    customer = nil
    before do
      customer = create(:customer)
      get :index, format: :json
    end
    it do
      user = JSON.parse(response.body)[0]
      expect(response).to be_success
      expect(user['email']).to eq(customer[:email])
    end

  end


end
