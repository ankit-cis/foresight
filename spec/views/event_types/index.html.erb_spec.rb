require 'rails_helper'

RSpec.describe "event_types/index", type: :view do
  before(:each) do
    assign(:event_types, [
      EventType.create!(
        :name => "Name",
        :event_type_const => "Event Type Const",
        :description => "MyText"
      ),
      EventType.create!(
        :name => "Name",
        :event_type_const => "Event Type Const",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of event_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Event Type Const".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
