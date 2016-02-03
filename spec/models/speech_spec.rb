require 'rails_helper'

RSpec.describe Speech, type: :model do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}

  describe "attributes" do
    it "should respond to speech_name attribute" do
      expect(my_speech).to respond_to(:speech_name)
    end

    it "belongs to position" do
      my_speech {should belong_to(:position)}
    end
  end

  describe "invalid" do
    it "should be invalid when name is nil" do
      speech = Speech.new(speech_name: nil, position_id: my_speech.position_id)

      expect(speech).to be_invalid
    end
  end

end
