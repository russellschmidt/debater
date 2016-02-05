class Contention < ActiveRecord::Base
  has_many :arguments, dependent: :destroy
  belongs_to :speech

  validates :topic, presence: true
  validates :speech_id, presence: true

  def speech
    self.speech_id
  end
end
