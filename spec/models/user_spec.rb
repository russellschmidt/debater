require 'rails_helper'

RSpec.describe User, type: :model do
  let(:my_user) {create(:user)}

  describe "attributes" do
    it "should respond to email" do
      expect(my_user).to respond_to(:email)
    end

    it "should respond to password" do
      expect(my_user).to respond_to(:password)
    end

    it "should respond to confirmed at" do
      expect(my_user).to respond_to(:confirmed_at)
    end
  end
end
