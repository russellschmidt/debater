class DropDebates < ActiveRecord::Migration
  def change
    drop_table :debates do |t|
      t.string   :title
      t.text     :topic
      t.integer  :user_id
      t.timestamps null: false
    end
  end
end
