require 'rails_helper'

RSpec.describe "statuses/edit", type: :view do
  before(:each) do
    @status = assign(:status, Status.create!(
      :name => "MyString",
      :description => "MyText",
      :status_constant => "MyString"
    ))
  end

  it "renders the edit status form" do
    render

    assert_select "form[action=?][method=?]", status_path(@status), "post" do

      assert_select "input[name=?]", "status[name]"

      assert_select "textarea[name=?]", "status[description]"

      assert_select "input[name=?]", "status[status_constant]"
    end
  end
end
