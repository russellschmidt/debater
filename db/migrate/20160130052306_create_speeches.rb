class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.references :position, index: true, foreign_key: true
      t.integer :name

      t.timestamps null: false
    end
  end
end
