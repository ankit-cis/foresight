require 'rails_helper'

RSpec.describe "event_types/show", type: :view do
  before(:each) do
    @event_type = assign(:event_type, EventType.create!(
      :name => "Name",
      :event_type_const => "Event Type Const",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Event Type Const/)
    expect(rendered).to match(/MyText/)
  end
end
