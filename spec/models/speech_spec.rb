require 'rails_helper'

RSpec.describe Speech, type: :model do
  let(:my_speech) {create(:speech)}

  describe "attributes" do
    it "should respond to name attribute" do
      expect(my_speech).to respond_to(:speech_name)
    end
  end

  describe "invalid" do
    it "should be invalid when name is nil" do
      speech = Speech.new(speech_name: nil, debate_id: my_speech.debate_id, position_id: my_speech.position_id)

      expect(speech).to be_invalid
    end
  end

end
