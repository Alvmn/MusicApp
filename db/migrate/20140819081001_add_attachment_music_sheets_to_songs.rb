class AddAttachmentMusicSheetsToSongs < ActiveRecord::Migration
  def self.up
    change_table :songs do |t|
      t.attachment :asheet
    end
  end

  def self.down
      remove_attachment :songs, :asheet
  end
end
