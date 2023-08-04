require "rails_helper"

RSpec.describe StatusMailer, type: :mailer do
  describe "false_alarm" do
    let(:mail) { StatusMailer.false_alarm }

    it "renders the headers" do
      expect(mail.subject).to eq("False alarm")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
