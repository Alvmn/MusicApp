class AddAttachmentMusicSheetsToSongs < ActiveRecord::Migration
  def self.up
    change_table :songs do |t|
      t.attachment :music_sheets
    end
  end

  def self.down
    remove_attachment :songs, :music_sheets
  end
end
