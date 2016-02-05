class Rebuttal < ActiveRecord::Base
  belongs_to :contention
  belongs_to :refutation, class_name: "Contention"

  def contention
    self.contention_id
  end
end
