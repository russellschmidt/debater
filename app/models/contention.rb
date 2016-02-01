class Contention < ActiveRecord::Base
  belongs_to :speech

  validates :topic, presence: true
end
