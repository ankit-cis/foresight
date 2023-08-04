require 'rails_helper'

RSpec.describe "user_devices/index", type: :view do
  before(:each) do
    assign(:user_devices, [
      UserDevice.create!(),
      UserDevice.create!()
    ])
  end

  it "renders a list of user_devices" do
    render
  end
end
