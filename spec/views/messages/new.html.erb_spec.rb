require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :company => nil,
      :title => "MyString",
      :body => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input[name=?]", "message[company_id]"

      assert_select "input[name=?]", "message[title]"

      assert_select "input[name=?]", "message[body]"

      assert_select "textarea[name=?]", "message[content]"
    end
  end
end
