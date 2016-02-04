require 'rails_helper'
require 'faker'

RSpec.describe ArgumentsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}
  let(:my_position) {create(:position, user: my_user, debate: my_debate)}
  let(:my_speech) {create(:speech, position_id: my_position.id)}
  let(:my_contention) {create(:contention, speech_id: my_speech.id)}
  let!(:my_argument) {create(:argument, contention_id: my_contention.id)}

  describe "get NEW" do
    it "returns the new view" do
      get :new, contention_id: my_contention
      expect(response).to render_template("new")
    end
  end

  describe "post UPDATE" do
    it "increases the number of Arguments by 1" do
      expect{post :create, argument: {claim: my_argument.claim, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: my_contention.id }}.to change(Argument, :count).by 1
    end

    it "assigns the new argument to @argument" do
      post :create, argument: {claim: my_argument.claim, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: my_contention.id }
      expect(assigns(:argument)).to eq Argument.last
    end

    context "bad data stops UPDATE" do
      it "expects invalid contention with nil claim to not change the number of Contentions" do
        expect{post :create, argument: {claim: nil, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: my_contention.id }}.not_to change(Argument, :count)
      end

      it "expects invalid contention with nil contention_id to not change the number of Contentions" do
        expect{post :create, argument: {claim: my_argument.claim, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: nil }}.not_to change(Argument, :count)
      end
    end
  end

  describe "get EDIT" do
    it "returns the edit view" do
      get :edit, id: my_argument.id
      expect(response).to render_template("edit")
    end
  end

  describe "put UPDATE" do

    it "updates speech with the expected attributes" do
      new_claim = "This is my new claim"
      put :update, id: my_argument.id, argument: {claim: new_claim, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: my_argument.contention_id }
      updated_argument = assigns(:argument)

      expect(updated_argument.id).to eq my_argument.id
      expect(updated_argument.claim).to eq new_claim
      expect(updated_argument.contention_id).to eq my_argument.contention_id
    end

    it "won't save an invalid update where claim eq nil" do
      new_claim = nil
      put :update, id: my_argument.id, argument: {claim: nil, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: my_argument.contention_id }

      expect(my_argument.claim).not_to eq nil
    end

    it "won't save an invalid update where claim eq nil" do
      new_contention = nil
      put :update, id: my_argument.id, argument: {claim: my_argument.claim, warrant: my_argument.warrant, impact: my_argument.impact, citation: my_argument.citation, contention_id: nil }

      expect(my_argument.contention_id).not_to eq nil
    end
  end

  describe "delete DESTROY" do

    it "deletes the post" do
      delete :destroy, {id: my_argument}
      count = Argument.where({id: my_argument.id}).size
      expect(count).to eq 0
    end

    it "redirects to edit#speech" do
      delete :destroy, {id: my_argument}
      expect(response).to redirect_to edit_speech_path(my_argument.contention.speech)
    end
  end

end
