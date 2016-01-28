class Debate < ActiveRecord::Base
  validates :resolution, presence: true, length: { minimum:20, too_short: "Must be at least %{count} characters long"}
  validates :creator_id, presence: true

  belongs_to :creator, class_name: "User"
end
