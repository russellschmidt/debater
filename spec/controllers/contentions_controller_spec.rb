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

  describe "get EDIT" do
    it "returns the edit view" do
      get :edit, id: my_contention.id, speech_id: my_speech
      expect(response).to render_template("edit")
    end
  end

  describe "put UPDATE" do
    it "updates contention with the expected attributes" do
      new_topic = Faker::Lorem.sentence(5)
      new_summary = Faker::Lorem.paragraph(4)
      put :update, speech_id: my_speech.id, id: my_contention.id, contention: {topic: new_topic, summary: new_summary, speech_id: my_speech.id}
      updated_contention = assigns(:contention)

      expect(updated_contention.id).to eq my_contention.id
      expect(updated_contention.topic).to eq new_topic
      expect(updated_contention.summary).to eq new_summary
    end

    it "redirects to the updated speech" do
      new_topic = Faker::Lorem.sentence(2)
      new_summary = Faker::Lorem.paragraph(4)
      put :update, speech_id: my_speech.id, id: my_contention.id, contention: {topic: new_topic, summary: new_summary, speech_id: my_speech.id}

      expect(response).to redirect_to edit_speech_path(my_speech)
    end

    it "won't save an invalid update" do
      new_topic = nil
      put :update, speech_id: my_speech.id, id: my_contention.id, contention: {topic: new_topic, summary: my_contention.summary, speech_id: my_speech.id}

      expect(my_position.criterion).not_to eq nil
    end
  end

  describe "delete DESTROY" do
    it "deletes the post" do
      delete :destroy, {id: my_contention, speech_id: my_speech.id}
      count = Contention.where({id: my_contention.id}).size
      expect(count).to eq 0
    end

    it "redirects to debate show" do
      delete :destroy, {id: my_contention, speech_id: my_speech.id}
      expect(response).to redirect_to edit_speech_path(my_speech)
    end
  end
end
