class Argument < ActiveRecord::Base
  belongs_to :contention

  validates :claim, presence: true
  validates :contention, presence: true

end
