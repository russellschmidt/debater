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

  end

  describe "post UPDATE" do

  end

  describe "delete DESTROY" do

  end
  
end
