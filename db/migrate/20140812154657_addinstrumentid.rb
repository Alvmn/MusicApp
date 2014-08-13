class Addinstrumentid < ActiveRecord::Migration
  def change
  	rename_column(:songs, :instrument, :instrument_id)
  	change_column(:songs, :instrument_id, :integer)
  end
end
