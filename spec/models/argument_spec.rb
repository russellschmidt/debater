require 'rails_helper'

RSpec.describe Argument, type: :model do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}
  let(:my_contention) {create(:contention, speech_id: my_speech.id)}
  let(:my_argument) {create(:argument, contention: my_contention)}

  context "responds to attributes" do
    it "responds to claim" do
      expect(my_argument).to respond_to(:claim)
    end

    it "responds to warrant" do
      expect(my_argument).to respond_to(:warrant)
    end

    it "responds to impact" do
      expect(my_argument).to respond_to(:impact)
    end

    it "responds to citation" do
      expect(my_argument).to respond_to(:citation)
    end

    it "belongs to contention" do
      my_argument {should belong_to(:contention)}
    end
  end

  context "valid input" do
    it "is valid with a claim, warrant, impact and citation" do
      expect(my_argument).to be_valid
    end
  end

  context "invalid input" do
    it "is invalid with a nil claim" do
      bad_argument = my_argument
      bad_argument.claim = nil
      expect(bad_argument).to be_invalid
    end

    it "is invalid with a nil contention" do
      bad_argument = my_argument
      bad_argument.contention = nil
      expect(bad_argument).to be_invalid
    end
  end
end
