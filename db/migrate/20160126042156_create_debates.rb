class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :resolution
      t.references :creator, index: true

      t.timestamps null: false
    end
    add_foreign_key :debates, :users, column: :creator_id
  end
end
