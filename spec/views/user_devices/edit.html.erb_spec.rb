require 'rails_helper'

RSpec.describe "user_devices/edit", type: :view do
  before(:each) do
    @user_device = assign(:user_device, UserDevice.create!())
  end

  it "renders the edit user_device form" do
    render

    assert_select "form[action=?][method=?]", user_device_path(@user_device), "post" do
    end
  end
end
