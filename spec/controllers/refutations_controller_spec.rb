require 'rails_helper'
require 'faker'

RSpec.describe RefutationsController, type: :controller do

  let(:my_user) {create(:user)}
  let(:counter_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:counter_position) {create(:position, user: counter_user, debate:my_debate, affirmative: !my_position.affirmative)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}
  let(:counter_speech) {create(:speech, position_id: counter_position.id)}
  let!(:my_contention) {create(:contention, speech_id: my_speech.id)}
  let!(:my_refutation) {create(:contention, speech_id: counter_speech.id, assertion_id: my_contention.id)}

  describe "get NEW" do
    it "returns the new view" do
      get :new, use_route: :new_contention_refutation, contention_id: my_contention.id, speech_id: counter_speech.id
      expect(response).to render_template("new")
    end
  end

  describe "post UPDATE" do
    it "increases the number of Contentions by 1" do
      expect{post :create, use_route: :contention_refutations, contention_id: my_contention.id, speech_id: counter_speech.id, refutation: {topic: my_refutation.topic, summary: my_refutation.summary, speech_id: counter_speech.id, assertion_id: my_contention.id}}.to change(Contention, :count).by 1
    end

    it "assigns the new refutation to Contention" do
      post :create, use_route: :contention_refutations, contention_id: my_contention.id, speech_id: counter_speech.id, refutation: {topic: my_refutation.topic, summary: my_refutation.summary, speech_id: counter_speech.id, assertion_id: my_contention.id}
      expect(assigns(:refutation)).to eq Contention.last
    end

    context "bad data stops UPDATE" do
      it "expects invalid refutation with nil topic to not change the number of Contentions" do
        expect{post :create, use_route: :contention_refutations, contention_id: my_contention.id, speech_id: counter_speech.id, refutation: {topic: nil, summary: my_refutation.summary, speech_id: counter_speech.id, assertion_id: my_contention.id}}.not_to change(Contention, :count)
      end
    end
  end

  describe "get EDIT" do
    it "returns the edit view" do
      get :edit, use_route: :edit_contention_refutation, contention_id: my_contention.id, id: my_refutation.id
      expect(response).to render_template("edit")
    end
  end

  describe "put UPDATE" do
    it "updates refutation with the expected attributes" do
      new_topic = Faker::Lorem.sentence(5)
      new_summary = Faker::Lorem.paragraph(4)
      put :update, use_route: :contention_refutation, contention_id: my_contention.id, id: my_refutation.id, refutation: {topic: new_topic, summary: new_summary, speech_id: counter_speech.id, assertion_id: my_contention.id}
      updated_contention = assigns(:refutation)

      expect(updated_contention.id).to eq my_refutation.id
      expect(updated_contention.topic).to eq new_topic
      expect(updated_contention.summary).to eq new_summary
    end

    it "redirects to the updated speech" do
      new_topic = Faker::Lorem.sentence(2)
      new_summary = Faker::Lorem.paragraph(4)
      put :update, use_route: :contention_refutation, contention_id: my_contention.id, id: my_refutation.id, refutation: {topic: new_topic, summary: new_summary, speech_id: counter_speech.id, assertion_id: my_contention.id}

      expect(response).to redirect_to edit_speech_path(counter_speech)
    end

    it "won't save an invalid update" do
      new_topic = nil
      put :update, use_route: :contention_refutation, contention_id: my_contention.id, id: my_refutation.id, refutation: {topic: new_topic, summary: "blah blah", speech_id: counter_speech.id, assertion_id: my_contention.id}

      expect(my_refutation.topic).not_to eq nil
    end
  end

  describe "delete DESTROY" do
    it "deletes the post" do
      delete :destroy, {id: my_refutation, contention_id: my_contention.id}
      count = Contention.where({id: my_refutation.id}).size
      expect(count).to eq 0
    end

    it "redirects to debate show" do
      delete :destroy, {id: my_refutation, contention_id: my_contention.id}
      expect(response).to redirect_to edit_speech_path(my_speech)
    end
  end
end
