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

  describe "post CREATE" do

  end
end
