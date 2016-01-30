class Speech < ActiveRecord::Base
  belongs_to :position
  belongs_to :debate, through: :position

  enum name: [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR]
end
