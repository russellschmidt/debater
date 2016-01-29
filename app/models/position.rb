class Position < ActiveRecord::Base
  validates_inclusion_of :affirmative, in: [true, false]
  validates :value, presence: true
  validates :criterion, presence: true

  belongs_to :debate
  belongs_to :user
end
