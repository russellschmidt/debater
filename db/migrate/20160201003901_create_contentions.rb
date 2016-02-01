class CreateContentions < ActiveRecord::Migration
  def change
    create_table :contentions do |t|
      t.string :topic
      t.text :summary
      t.references :speech, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
