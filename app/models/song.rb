class Song < ActiveRecord::Base
	has_many :midis
	has_many :music_sheets

	belongs_to :instrument
end
