class Speech < ActiveRecord::Base
  belongs_to :position

  validates :speech_name, presence: true
  validates :position_id, presence: true

  enum speech_name: [:OneAC, :OneNC, :OneAR, :OneNR, :TwoAR]

end
