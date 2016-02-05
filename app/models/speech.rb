class Speech < ActiveRecord::Base
  belongs_to :position
  has_many :contentions, dependent: :destroy

  validates :speech_name, presence: true
  validates :position_id, presence: true

  enum speech_name: [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR]

  #def position
  #  self.position
  #end

end
