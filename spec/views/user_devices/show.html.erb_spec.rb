require 'rails_helper'

RSpec.describe "user_devices/show", type: :view do
  before(:each) do
    @user_device = assign(:user_device, UserDevice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
