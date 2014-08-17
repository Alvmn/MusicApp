class AddASongwriterColumn < ActiveRecord::Migration
  def change
  	add_column :songs, :songwriter, :string
  end
end
