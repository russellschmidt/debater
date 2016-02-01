require 'rails_helper'
require 'faker'

RSpec.describe SpeechesController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let!(:my_speech) {create(:speech, position_id: my_position.id)}
  # lazy evaluation was creating two speeches for each post :create test

  describe "get NEW" do
    before :each do
      sign_in my_user
    end

    it "returns the NEW view" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "post CREATE" do
    before :each do
      sign_in my_user
    end

    it "increases the number of Speeches by 1" do
      expect{post :create, speech: {
        speech_name: my_speech.speech_name,
        position_id: my_speech.position_id}
      }.to change(Speech, :count).by 1
    end

    it "assigns the new speech to @speech" do
      post :create, speech: {
        speech_name: my_speech.speech_name,
        position_id: my_speech.position_id}
      expect(assigns(:speech)).to eq Speech.last
    end

    it "will not allow a new speech without a position" do
      expect{post :create, speech: {
        speech_name: my_speech.speech_name,
        position_id: nil}
      }.to change(Speech, :count).by 0
    end

    it "will not allow a new speech without a speech_name" do
      expect{post :create, speech: {
        speech_name: nil,
        position_id: my_speech.position_id}
      }.to change(Speech, :count).by 0
    end
  end

  describe "get EDIT" do
    before :each do
      sign_in my_user
    end

    it "returns the edit view" do
      get :edit, id: my_speech
      expect(response).to render_template("edit")
    end
  end

  describe "put UPDATE" do
    before :each do
      sign_in my_user
    end

    it "updates speech with the expected attributes" do
      new_speech_name = "TwoAR"
      put :update, id: my_speech.id, speech: {speech_name: new_speech_name, position_id: my_speech.position_id}
      updated_speech = assigns(:speech)

      expect(updated_speech.id).to eq my_speech.id
      expect(updated_speech.speech_name).to eq new_speech_name
      expect(updated_speech.position_id).to eq my_speech.position_id
    end

    it "won't save an invalid update" do
      new_speech_name = nil
      put :update, id: my_speech.id, speech: {speech_name: new_speech_name, position_id: my_speech.position_id}

      expect(my_speech.speech_name).not_to eq nil
    end
  end

  describe "delete DESTROY" do
    before :each do
      sign_in my_user
    end

    it "deletes the post" do
      delete :destroy, {id: my_speech}
      count = Position.where({id: my_speech.id}).size
      expect(count).to eq 0
    end

    it "redirects to debate show" do
      delete :destroy, {id: my_speech}
      expect(response).to redirect_to debate_path(my_speech.position.debate)
    end
  end
end
