require 'rails_helper'

RSpec.describe "settings/show", type: :view do
  before(:each) do
    @setting = assign(:setting, Setting.create!(
      :consumer_key => "Consumer Key",
      :consumer_secret => "Consumer Secret",
      :prompa_url => "Prompa Url",
      :prompa_token => "Prompa Token",
      :api_token => "Api Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Consumer Key/)
    expect(rendered).to match(/Consumer Secret/)
    expect(rendered).to match(/Prompa Url/)
    expect(rendered).to match(/Prompa Token/)
    expect(rendered).to match(/Api Token/)
  end
end
