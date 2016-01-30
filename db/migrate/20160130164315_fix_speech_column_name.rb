class FixSpeechColumnName < ActiveRecord::Migration
  def change
    rename_column :speeches, :name, :speech_name
  end
end
