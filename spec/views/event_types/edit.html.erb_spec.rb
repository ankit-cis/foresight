require 'rails_helper'

RSpec.describe "event_types/edit", type: :view do
  before(:each) do
    @event_type = assign(:event_type, EventType.create!(
      :name => "MyString",
      :event_type_const => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit event_type form" do
    render

    assert_select "form[action=?][method=?]", event_type_path(@event_type), "post" do

      assert_select "input[name=?]", "event_type[name]"

      assert_select "input[name=?]", "event_type[event_type_const]"

      assert_select "textarea[name=?]", "event_type[description]"
    end
  end
end
