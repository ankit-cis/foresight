require 'rails_helper'

RSpec.describe "event_types/new", type: :view do
  before(:each) do
    assign(:event_type, EventType.new(
      :name => "MyString",
      :event_type_const => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new event_type form" do
    render

    assert_select "form[action=?][method=?]", event_types_path, "post" do

      assert_select "input[name=?]", "event_type[name]"

      assert_select "input[name=?]", "event_type[event_type_const]"

      assert_select "textarea[name=?]", "event_type[description]"
    end
  end
end
