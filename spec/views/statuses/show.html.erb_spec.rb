require 'rails_helper'

RSpec.describe "statuses/show", type: :view do
  before(:each) do
    @status = assign(:status, Status.create!(
      :name => "Name",
      :description => "MyText",
      :status_constant => "Status Constant"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status Constant/)
  end
end
