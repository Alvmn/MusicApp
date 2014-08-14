class CategoriesSongsTable < ActiveRecord::Migration
  def change
  	create_table :categories_songs do |t|
  		t.belongs_to :song
  		t.belongs_to :category
  	end
  end
end
