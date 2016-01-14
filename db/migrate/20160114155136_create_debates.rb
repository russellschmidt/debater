class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :title
      t.text :topic
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
