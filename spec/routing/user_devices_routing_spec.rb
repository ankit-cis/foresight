require "rails_helper"

RSpec.describe UserDevicesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_devices").to route_to("user_devices#index")
    end

    it "routes to #new" do
      expect(:get => "/user_devices/new").to route_to("user_devices#new")
    end

    it "routes to #show" do
      expect(:get => "/user_devices/1").to route_to("user_devices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_devices/1/edit").to route_to("user_devices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_devices").to route_to("user_devices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_devices/1").to route_to("user_devices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_devices/1").to route_to("user_devices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_devices/1").to route_to("user_devices#destroy", :id => "1")
    end

  end
end
