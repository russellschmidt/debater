class Debate < ActiveRecord::Base
  belongs_to :user
  has_many :disputes
  has_many :arguments, through: :disputes
end
