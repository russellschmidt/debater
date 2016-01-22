class Dispute < ActiveRecord::Base
  belongs_to :debate
  belongs_to :user

  has_many :arguments
end
