require 'rails_helper'

RSpec.describe Contention, type: :model do
  let(:my_contention) {create(:contention)}

  context "responds to attributes" do
    it "responds to topic" do
      expect(my_contention).to respond_to(:topic)
    end

    it "responds to summary" do
      expect(my_contention).to respond_to(:summary)    
    end
  end
end
