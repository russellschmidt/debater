FactoryGirl.define do

  factory :speech do
    speech_name  { [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR].sample }
    position_id  Position.first
  end
end
