require 'rails_helper'

RSpec.describe DebatesController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_debate) {create(:debate, user: my_user)}

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_debate to @debates" do
      get :index
      expect(assigns(:debates)).to eq([my_debate])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end
