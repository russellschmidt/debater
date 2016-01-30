class AddDebateToSpeeches < ActiveRecord::Migration
  def change
    add_reference :speeches, :debate, index: true, foreign_key: true
  end
end
