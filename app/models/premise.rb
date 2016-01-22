class Premise < ActiveRecord::Base
  belongs_to :argument
  belongs_to :user

end
