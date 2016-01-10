require 'spec_helper'
require 'rails_helper'

RSpec.describe GreetingsController, type: :controller do
  describe "get HELLO" do
    it "returns the hello view" do
      get :hello
      expect(response).to render_template("hello")
    end
  end
end
