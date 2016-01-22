class Argument < ActiveRecord::Base
  belongs_to :debate, through: :dispute
  belongs_to :user
  has_many :premises
end
