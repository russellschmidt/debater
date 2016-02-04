class Position < ActiveRecord::Base
  validates :affirmative, inclusion: { in: [true, false] }
  validates :value, presence: true
  validates :criterion, presence: true

  belongs_to :debate
  belongs_to :user
  has_many :speeches, dependent: :destroy

  scope :aff, -> {where(affirmative: true) }
  scope :neg, -> {where(affirmative: false) }

  def debate
    self.debate_id
  end
end
