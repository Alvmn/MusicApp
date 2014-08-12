class CreateMidis < ActiveRecord::Migration
  def change
    create_table :midis do |t|
	  t.integer :song_id
  	  t.string :url
      # t.timestamps
    end
  end
end
