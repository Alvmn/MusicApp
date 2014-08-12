class InstrumentController < ApplicationController
	before_action :set_instrument, only: [:show]

	def index
		@instruments = Instrument.all
	end

	def show
		@song = @instrument.songs.find params[:id]
	end
	def found_songs
		@songs = Song.where "title LIKE ?", "%#{params[:title]}%" # Mejorar para buscar canciones 
		#título parecido al introducido
	end

	protected

	def set_instrument
	  @instrument = Instrument.find(params[:id])
	end
end