class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :resolution
      t.references :creator, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :debates, :resolution
  end
end
