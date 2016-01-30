require 'rails_helper'
require 'faker'

RSpec.describe DebatesController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, creator_id: my_user.id)}

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_debate to @debates" do
      get :index
      expect(assigns(:debates)).to eq([my_debate])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index

    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: my_debate
      expect(response).to have_http_status(:success)
    end

    it "renders the correct debate" do
      debate = create(:debate, resolution: my_debate.resolution, creator_id: my_debate.creator_id)
      get :show, id: debate
      expect(assigns(:debate)).to eq debate
    end
  end

  describe "GET new" do
    before :each do
      sign_in my_user
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before :each do
      sign_in my_user
    end

    it "increases the number of Debates by 1" do
      expect{post :create, debate: {resolution: Faker::Lorem.sentence(10), creator_id: my_user.id}}.to change(Debate, :count).by 1
    end

    it "assigns the new debate to @debate" do
      post :create, debate: {resolution: Faker::Lorem.sentence(10), creator_id: my_user.id}
      expect(assigns(:debate)).to eq Debate.last
    end

    it "expects invalid debates to not change the number of Debates" do
      expect{post :create, debate: {resolution: nil, creator_id: my_user.id}}.not_to change(Debate, :count)
    end

  end

  describe "GET edit" do
    before :each do
      sign_in my_user
    end

    it "returns http success" do
      get :edit, id: my_debate
      expect(response).to have_http_status(:success)
    end

    it "assings the correct debate to @debate" do
      debate = create(:debate, resolution: my_debate.resolution, creator_id: my_debate.creator_id)
      get :show, id: debate
      expect(assigns(:debate)).to eq debate
    end
  end

  describe "PUT update" do
    before :each do
      sign_in my_user
    end

    it "updates debate with the expected attributes" do
      new_resolution = Faker::Lorem.sentence(9)

      put :update, id: my_debate.id, debate: {resolution: new_resolution, creator_id: my_debate.creator_id}

      updated_debate = assigns(:debate)
      expect(updated_debate.id).to eq my_debate.id
      expect(updated_debate.resolution).to eq new_resolution
      expect(updated_debate.creator_id).to eq my_debate.creator_id
    end

    it "redirects to the updated post" do
      new_resolution = Faker::Lorem.sentence(8)

      put :update, id: my_debate.id, debate: {resolution: new_resolution, creator_id: my_debate.creator_id}
      expect(response).to redirect_to my_debate
    end

    it "won't save an invalid update" do
      new_resolution = nil

      put :update, id: my_debate.id, debate: {resolution: new_resolution, creator_id: my_debate.creator_id}
      expect(my_debate.resolution).not_to eq nil
    end
  end

  describe "DELETE destroy" do
    before :each do
      sign_in my_user
    end

    it "deletes the post" do
      delete :destroy, {id: my_debate.id}
      count = Debate.where({id: my_debate.id}).size
      expect(count).to eq 0
    end

    it "redirects to debates index" do
      delete :destroy, {id: my_debate.id}
      expect(response).to redirect_to debates_path
    end
  end
end
