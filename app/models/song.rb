class Song < ActiveRecord::Base
	resourcify

	has_many :midis, :dependent => :destroy
	has_many :music_sheets, :dependent => :destroy
	has_many :videos, :dependent => :destroy
	has_many :comments, :dependent => :destroy
 	# El :dependent => destroy es para que cuando se borre una song, se borren sus respectivos "hijos"
	belongs_to :instrument

	has_and_belongs_to_many :categories
	has_and_belongs_to_many :tags

	validates :title, presence: true
    validates :title, uniqueness: true
end
