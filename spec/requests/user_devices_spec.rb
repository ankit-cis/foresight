require 'rails_helper'

RSpec.describe "UserDevices", type: :request do
  describe "GET /user_devices" do
    it "works! (now write some real specs)" do
      get user_devices_path
      expect(response).to have_http_status(200)
    end
  end
end
