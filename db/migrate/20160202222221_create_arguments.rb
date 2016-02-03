class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.string :claim
      t.string :warrant
      t.string :impact
      t.string :citation
      t.references :contention, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
