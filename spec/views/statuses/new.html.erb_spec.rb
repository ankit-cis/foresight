require 'rails_helper'

RSpec.describe "statuses/new", type: :view do
  before(:each) do
    assign(:status, Status.new(
      :name => "MyString",
      :description => "MyText",
      :status_constant => "MyString"
    ))
  end

  it "renders new status form" do
    render

    assert_select "form[action=?][method=?]", statuses_path, "post" do

      assert_select "input[name=?]", "status[name]"

      assert_select "textarea[name=?]", "status[description]"

      assert_select "input[name=?]", "status[status_constant]"
    end
  end
end
