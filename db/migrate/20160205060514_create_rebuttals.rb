class CreateRebuttals < ActiveRecord::Migration
  def change
    create_table :rebuttals do |t|
      t.integer :contention_id
      t.integer :refutation_id

      t.timestamps null: false
    end
  end
end
