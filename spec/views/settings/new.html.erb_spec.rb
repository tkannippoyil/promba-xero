require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      :consumer_key => "MyString",
      :consumer_secret => "MyString",
      :prompa_url => "MyString",
      :prompa_token => "MyString",
      :api_token => "MyString"
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input#setting_consumer_key[name=?]", "setting[consumer_key]"

      assert_select "input#setting_consumer_secret[name=?]", "setting[consumer_secret]"

      assert_select "input#setting_prompa_url[name=?]", "setting[prompa_url]"

      assert_select "input#setting_prompa_token[name=?]", "setting[prompa_token]"

      assert_select "input#setting_api_token[name=?]", "setting[api_token]"
    end
  end
end
