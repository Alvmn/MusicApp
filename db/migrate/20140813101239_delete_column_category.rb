class DeleteColumnCategory < ActiveRecord::Migration
  def change
  	remove_column :songs, :category
  end
end
