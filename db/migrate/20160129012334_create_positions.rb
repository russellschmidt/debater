class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.boolean :affirmative
      t.string :value
      t.string :criterion
      t.references :debate, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
