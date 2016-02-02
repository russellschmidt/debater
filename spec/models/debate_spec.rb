require 'rails_helper'
require 'faker'

RSpec.describe Debate, type: :model do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}

  it "is valid with a resolution and author" do
    expect(my_debate).to be_valid
  end

  it "belongs to user" do
    my_debate {should belong_to(:user)}
  end

  context "should fail when" do
    it "is invalid without a resolution" do
      bad_res_debate = Debate.new(resolution: nil, creator_id: my_user.id)
      expect(bad_res_debate).to be_invalid
    end

    it "is invalid if the resolution is under 20 characters" do
      short_res_debate = Debate.new(resolution: Faker::Lorem.characters(19), creator_id: my_user.id)
      expect(short_res_debate).to be_invalid
    end

    it "is invalid without an author" do
      bad_user_debate = Debate.new(resolution: Faker::Lorem.characters(20), creator_id: nil)
      expect(bad_user_debate).to be_invalid
    end
  end
end
