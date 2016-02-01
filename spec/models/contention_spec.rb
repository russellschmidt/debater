require 'rails_helper'

RSpec.describe Contention, type: :model do
  let(:my_contention) {create(:contention)}

  context "responds to attributes" do
    it "responds to topic" do
      expect(my_contention).to respond_to(:topic)
    end

    it "responds to summary" do
      expect(my_contention).to respond_to(:summary)
    end
  end

  context "valid input" do
    it "is valid with a topic, summary and speech" do
      expect(my_contention).to be_valid
    end
  end

  context "invalid input" do
    it "is invalid with a nil topic" do
      bad_contention = Contention.new(
        topic: nil,
        summary: "This is a summary of a contention",
        speech_id: Speech.first)
      expect(bad_contention).to be_invalid
    end
  end
end
