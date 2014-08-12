class CreateMusicSheets < ActiveRecord::Migration
  def change
    create_table :music_sheets do |t|
	  t.integer :song_id
  	  t.string :url
      # t.timestamps
    end
  end
end
