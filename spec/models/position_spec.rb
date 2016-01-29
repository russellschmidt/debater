require 'rails_helper'
require 'faker'

RSpec.describe Position, type: :model do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, debate: my_debate, user: my_user)}

  describe "attributes" do
    it "should respond to affirmative" do
      expect(my_position).to respond_to(:affirmative)
    end

    it "should respond to value" do
      expect(my_position).to respond_to(:value)
    end

    it "should respond to criterion" do
      expect(my_position).to respond_to(:criterion)
    end

    it "should respond to debate" do
      expect(my_position).to respond_to(:debate)
    end

    it "should respond to user" do
      expect(my_position).to respond_to(:user)
    end
  end

  describe "valid attributes" do
    it "is valid with affirmative, value, criterion, debate and user" do
      expect(my_position).to be_valid
    end
  end

  

end
