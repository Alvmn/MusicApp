class InstrumentController < ApplicationController
	def index
		@songs = Song.where "instrument = ?", params[:instrument]
	end

	def show
		@song = Song.find params[:id]
	end
	def found_songs
		@songs = Song.where "title LIKE ?", "%#{params[:title]}%" # Mejorar para buscar canciones 
		#título parecido al introducido
	end
end