require 'rails_helper'

RSpec.describe "user_devices/new", type: :view do
  before(:each) do
    assign(:user_device, UserDevice.new())
  end

  it "renders new user_device form" do
    render

    assert_select "form[action=?][method=?]", user_devices_path, "post" do
    end
  end
end
