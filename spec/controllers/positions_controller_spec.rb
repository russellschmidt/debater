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

  describe "post UPDATE" do
    before :each do
      sign_in my_user
    end

    it "updates position with the expected attributes" do
      new_criterion = Faker::Lorem.sentence(2)
      put :update, debate_id: my_debate.id, id: my_position.id, position: {value: my_position.value, criterion: new_criterion, user: my_user, affirmative: my_position.affirmative}
      updated_position = assigns(:position)

      expect(updated_position.id).to eq my_position.id
      expect(updated_position.criterion).to eq new_criterion
      expect(updated_position.value).to eq my_position.value
    end

    it "redirects to the updated post" do
      new_criterion = Faker::Lorem.sentence(2)
      put :update, debate_id: my_debate.id, id: my_position.id, position: {value: my_position.value, criterion: new_criterion, user: my_user, affirmative: my_position.affirmative}

      expect(response).to redirect_to my_debate
    end

    it "won't save an invalid update" do
      new_criterion = nil
      put :update, debate_id: my_debate.id, id: my_position.id, position: {value: my_position.value, criterion: new_criterion, user: my_user, affirmative: my_position.affirmative}

      expect(my_position.criterion).not_to eq nil
    end
  end

  describe "delete DESTROY" do
    before :each do
      sign_in my_user
    end

    it "deletes the post" do
      delete :destroy, {id: my_position, debate_id: my_debate.id}
      count = Position.where({id: my_position.id}).size
      expect(count).to eq 0
    end

    it "redirects to debate show" do
      delete :destroy, {id: my_position, debate_id: my_debate.id}
      expect(response).to redirect_to debate_path(my_debate)
    end
  end

end
