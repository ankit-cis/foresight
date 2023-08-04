require "rails_helper"

RSpec.describe SettingsMailer, type: :mailer do
  describe "upgrade_reset" do
    let(:mail) { SettingsMailer.upgrade_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Upgrade reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
