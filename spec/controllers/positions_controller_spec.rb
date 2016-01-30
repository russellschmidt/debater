require 'rails_helper'
require 'faker'

RSpec.describe PositionsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}

  describe "get NEW" do
    before :each do
      sign_in my_user
    end

    it "returns the new view" do
      get :new, debate_id: my_debate
      expect(response).to render_template("new")
    end
  end

  describe "post CREATE" do
    before :each do
      sign_in my_user
    end

    it "increases the number of Positions by 1" do
      expect{post :create, debate_id: my_debate.id, position: {
        affirmative: [true, false].sample,
        value: Faker::Lorem.word,
        criterion: Faker::Lorem.word,
        user: my_user.id,
        debate: my_debate.id}
      }.to change(Position, :count).by 1
    end

    it "assigns the new position to @position" do
      post :create, debate_id: my_debate.id, position: {
        affirmative: [true, false].sample,
        value: Faker::Lorem.word,
        criterion: Faker::Lorem.word,
        user: my_user.id,
        debate: my_debate.id}
      expect(assigns(:position)).to eq Position.last
    end

    it "expects invalid debate value to not change the number of Positons" do
      expect{post :create, debate_id: my_debate.id, position: {
        affirmative: [true, false].sample,
        value: nil,
        criterion: Faker::Lorem.word,
        user: my_user.id,
        debate: my_debate.id}
      }.not_to change(Position, :count)
    end
  end

  describe "get EDIT" do
    before :each do
      sign_in my_user
    end

    it "returns the edit view" do
      get :edit, id: my_position, debate_id: my_debate
      expect(response).to render_template("edit")
    end
  end

end
