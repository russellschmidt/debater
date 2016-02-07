require 'rails_helper'
require 'faker'

RSpec.describe ContentionsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:counter_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:counter_position) {create(:position, user: counter_user, debate:my_debate, affirmative: !my_position.affirmative)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}
  let(:counter_speech) {create(:speech, position_id: counter_position)}
  let!(:my_contention) {create(:contention, speech_id: my_speech.id)}
  let!(:my_refutation) {create(:contention, speech_id: counter_speech.id, assertion_id: my_contention.id)}

  describe "get NEW" do
    it "returns the new view" do
      get :new, speech_id: counter_speech.id
      expect(response).to render_template("new")
    end
  end

  describe "post CREATE" do

  end

  describe "get EDIT" do

  end

  describe "put UPDATE" do
  end

  describe "delete DESTROY" do
  end
end
