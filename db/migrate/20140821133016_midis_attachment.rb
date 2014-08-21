class MidisAttachment < ActiveRecord::Migration
    def self.up
    change_table :midis do |t|
      t.attachment :audio_file
    end
  end

  def self.down
      remove_attachment :midis, :audio_file
  end
end
