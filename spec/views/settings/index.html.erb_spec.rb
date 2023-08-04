require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        :company => nil,
        :notification_email => "Notification Email"
      ),
      Setting.create!(
        :company => nil,
        :notification_email => "Notification Email"
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Notification Email".to_s, :count => 2
  end
end
