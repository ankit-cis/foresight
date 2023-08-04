require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      :company => nil,
      :notification_email => "MyString"
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input[name=?]", "setting[company_id]"

      assert_select "input[name=?]", "setting[notification_email]"
    end
  end
end
