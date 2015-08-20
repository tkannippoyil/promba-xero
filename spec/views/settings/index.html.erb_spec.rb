require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        :consumer_key => "Consumer Key",
        :consumer_secret => "Consumer Secret",
        :prompa_url => "Prompa Url",
        :prompa_token => "Prompa Token",
        :api_token => "Api Token"
      ),
      Setting.create!(
        :consumer_key => "Consumer Key",
        :consumer_secret => "Consumer Secret",
        :prompa_url => "Prompa Url",
        :prompa_token => "Prompa Token",
        :api_token => "Api Token"
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", :text => "Consumer Key".to_s, :count => 2
    assert_select "tr>td", :text => "Consumer Secret".to_s, :count => 2
    assert_select "tr>td", :text => "Prompa Url".to_s, :count => 2
    assert_select "tr>td", :text => "Prompa Token".to_s, :count => 2
    assert_select "tr>td", :text => "Api Token".to_s, :count => 2
  end
end
