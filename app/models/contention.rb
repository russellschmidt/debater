class Contention < ActiveRecord::Base
  belongs_to :speech

  validates :topic, presence: true
  validates :speech_id, presence: true
end
