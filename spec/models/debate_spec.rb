require 'rails_helper'

RSpec.describe Debate, type: :model do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, user: my_user)}

  describe "attributes" do
    it "should respond to title" do
      expect(my_debate).to respond_to(:title)
    end

    it "should respond to topic" do
      expect(my_debate).to respond_to(:topic)
    end

    it "should respond to user" do
      expect(my_debate).to respond_to(:user)
    end
  end
end
