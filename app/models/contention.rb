class Contention < ActiveRecord::Base
  belongs_to :speech
  has_many :arguments

  validates :topic, presence: true
  validates :speech_id, presence: true
end
