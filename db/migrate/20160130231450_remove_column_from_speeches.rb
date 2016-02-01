class RemoveColumnFromSpeeches < ActiveRecord::Migration
  def change
    remove_column :speeches, :debate_id
  end
end
