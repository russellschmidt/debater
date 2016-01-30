class Speech < ActiveRecord::Base
  belongs_to :position
  belongs_to :debate

  validates :name, presence: true

  enum name: [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR]
end
