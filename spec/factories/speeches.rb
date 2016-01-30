FactoryGirl.define do
  factory :speech do
    position { Position.all.sample }
    debate { Debate.all.sample }
    name { [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR].sample }
  end

end
