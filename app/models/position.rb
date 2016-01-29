class Position < ActiveRecord::Base
  validates :affirmative, presence: true
  validates :value, presence: true
  validates :criterion, presence: true
  

  belongs_to :debate
  belongs_to :user
end
