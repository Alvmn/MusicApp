class MusicSheetsAttachment < ActiveRecord::Migration
  def self.up
    change_table :music_sheets do |t|
      t.attachment :sheet_file
    end
  end

  def self.down
      remove_attachment :music_sheets, :sheet_file
  end
end

