class CreateContentions < ActiveRecord::Migration
  def change
    add_reference :contentions, :assertion, index: true
  end
end
