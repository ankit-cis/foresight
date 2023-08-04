require 'rails_helper'

RSpec.describe "statuses/index", type: :view do
  before(:each) do
    assign(:statuses, [
      Status.create!(
        :name => "Name",
        :description => "MyText",
        :status_constant => "Status Constant"
      ),
      Status.create!(
        :name => "Name",
        :description => "MyText",
        :status_constant => "Status Constant"
      )
    ])
  end

  it "renders a list of statuses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status Constant".to_s, :count => 2
  end
end
