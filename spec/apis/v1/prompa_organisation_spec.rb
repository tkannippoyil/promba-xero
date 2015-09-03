require 'spec_helper'
require "rails_helper"

describe Api::V1::PrompaOrganisationsController do

  describe 'new' do
    before do
      setting = create(:setting)
      get :new, api_token: setting.api_token , format: :json
    end
    it do
      response_data = JSON.parse(response.body)
      expect(response).to be_success
      expect(response_data['errors']).to eq({
        "organisation_id"=>["can't be blank"],
        "token"=>["can't be blank", "is invalid"]
      })
    end

  end


end
