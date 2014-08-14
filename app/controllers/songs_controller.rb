class SongsController < ApplicationController
	before_action :set_instrument
	def index
		@songs = @instrument.songs
	end
	def show
		@song = @instrument.songs.find params[:id]
	end
	def found_songs
		@songs = @instrument.songs.where "title LIKE ?", "%#{params[:title]}%" # Mejorar para buscar canciones 
		#título parecido al introducido
	end
	def new

	end
	protected

	def set_instrument
	  @instrument = Instrument.find params[:instrument_id]
	end
end
