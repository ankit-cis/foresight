require "rails_helper"

RSpec.describe AccidentMailer, type: :mailer do
  describe "new_accident_uploaded" do
    let(:mail) { AccidentMailer.new_accident_uploaded }

    it "renders the headers" do
      expect(mail.subject).to eq("New accident uploaded")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
