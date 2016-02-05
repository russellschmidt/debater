class Contention < ActiveRecord::Base
  has_many :arguments, dependent: :destroy
  belongs_to :speech

  has_many :refutations, class_name: "Contention", foreign_key: "assertion_id"
  belongs_to :assertion, class_name: "Contention"

  validates :topic, presence: true
  validates :speech_id, presence: true

  def speech
    self.speech_id
  end
end
