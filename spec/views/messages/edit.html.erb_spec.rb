require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :company => nil,
      :title => "MyString",
      :body => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input[name=?]", "message[company_id]"

      assert_select "input[name=?]", "message[title]"

      assert_select "input[name=?]", "message[body]"

      assert_select "textarea[name=?]", "message[content]"
    end
  end
end
