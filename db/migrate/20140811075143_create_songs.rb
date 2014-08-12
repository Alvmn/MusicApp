class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :image
      t.string :instrument
      t.string :cathegory
      t.string :tag1, default: nil
      t.string :tag2, default: nil
      t.string :tag3, default: nil
      t.string :tag4, default: nil
      t.string :tag5, default: nil
      t.string :tag6, default: nil
      t.string :tag7, default: nil
      t.string :tag8, default: nil      
      # t.timestamps
    end
  end
end
