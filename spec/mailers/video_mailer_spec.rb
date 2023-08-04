require "rails_helper"

RSpec.describe VideoMailer, type: :mailer do
  describe "new_video_uploaded" do
    let(:mail) { VideoMailer.new_video_uploaded }

    it "renders the headers" do
      expect(mail.subject).to eq("New video uploaded")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
