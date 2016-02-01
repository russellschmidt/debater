require 'rails_helper'
require 'faker'

RSpec.describe ContentionsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}
  let!(:my_contention) {create(:contention, speech_id: my_speech.id)}

  describe "get NEW" do
    it "returns the new view" do
      get :new, speech_id: my_speech
      expect(response).to render_template("new")
    end
  end

  describe "post UPDATE" do
    it "increases the number of Contentions by 1" do
      expect{post :create, speech_id: my_speech.id, contention: {topic: my_contention.topic, summary: my_contention.summary, speech_id: my_speech.id}}.to change(Contention, :count).by 1
    end

    it "assigns the new contention to @contention" do
      post :create, speech_id: my_speech.id, contention: {topic: my_contention.topic, summary: my_contention.summary, speech_id: my_speech.id}
      expect(assigns(:contention)).to eq Contention.last
    end

    context "bad data stops UPDATE" do
      it "expects invalid contention with nil topic to not change the number of Contentions" do
        expect{post :create, speech_id: my_speech.id, contention: {topic: nil, summary: my_contention.summary, speech_id: my_speech.id}}.not_to change(Contention, :count)
      end
    end
  end
end
