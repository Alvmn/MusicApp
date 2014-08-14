class Song < ActiveRecord::Base
	has_many :midis
	has_many :music_sheets

	belongs_to :instrument

	has_and_belongs_to_many :categories
	has_and_belongs_to_many :tags

	validates :title, presence: true
    validates :title, uniqueness: true
end
