class SongsController < ApplicationController
	before_action :set_instrument
	before_filter :authenticate_user!, except: [:index, :show]
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
		@song = @instrument.songs.new
	end

	def create
		@song = @instrument.songs.new(title: params[:song_title]) 
		category = Category.find_by name: params[:song_category]
		@song.categories << category
		if @song.save
			flash[:notice] = "Song succesfully created!"
			redirect_to action: 'index', controller: 'songs'
		else
			flash[:alert] = "Sorry, try again"
			render 'new'
		end

	end
	
	protected

	def set_instrument
	  @instrument = Instrument.find params[:instrument_id]
	end
end
