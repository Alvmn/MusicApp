class CreateTableSongsTags < ActiveRecord::Migration
  def change
    create_table :songs_tags do |t|
    	t.belongs_to :song 
    	t.belongs_to :tag
    end
  end
end
