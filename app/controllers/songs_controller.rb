class SongsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show] #autenticate! es una función creada por nosotros, más abajo
	before_action :set_instrument
	
	def index
		@songs = @instrument.songs
	end

	def show
		@instrument = Instrument.friendly.find params[:instrument_id]
		@song = @instrument.songs.friendly.find params[:id]
		@midis = @song.midis
		@videos = @song.videos
		@comments = @song.comments
	end

	def found_songs
		@songs = @instrument.songs.where "title LIKE ?", "%#{params[:title]}%"# Mejorar para buscar canciones 
		unless @songs.empty? 
		#título parecido al introducido
			render 'found_songs'
		else 
		flash[:alert] = 'Ooohps! We could not find your song, did you write it right?'
		render 'index'
		end	
	end

	def new
		@categories = Category.all
		@song = @instrument.songs.new
		authorize @song
	end

	def create
		@song = @instrument.songs.new(title: params[:song_title]) 
		authorize @song
		if @song.save
			categories_tags #Esto llama a la función categories tag de abajo/ no borrar xd
			youtube_link = @song.videos.create url: params[:youtube_link]
			midi_link = @song.midis.create url: params[:midi_link]
			flash[:alert] = "Song succesfully created!"
			redirect_to action: 'index', controller: 'songs'
		else
			flash[:alert] = "Sorry, try again"
			@categories = Category.all
			render 'new'
		end

	end

	def edit
      @song = @instrument.songs.friendly.find params[:id]
      authorize @song
  	end

  	def update
      song = @instrument.songs.friendly.find params[:id]
   	  song.update title: params[:song_title]
   	  authorize @song
   	  # youtube_videos = song.videos.update
	   if song.valid?
	   	  redirect_to action: 'index', controller: 'songs'
	   else
	      render 'edit'
	   end
  	end

	def destroy
	    @song = @instrument.songs.friendly.find params[:id]
	    @youtube_videos = @song.videos
	    @midis = @song.midis
	    authorize @song

	    if @song.destroy && @youtube_videos.destroy && @midis.destroy
	      flash[:alert] = "Song succesfully deleted!"
	      redirect_to action: 'index', controller: 'songs'
	    else
	      flash[:alert] = "Song NOT deleted!"
	      redirect_to action: 'index', controller: 'songs'
	    end

  	end
	
	protected

	def set_instrument
	  @instrument = Instrument.friendly.find params[:instrument_id]
	end

	def authenticate!
	   authenticate_admin! || authenticate_user!
	   @current_user = admin_signed_in? ? current_admin : current_user
	end

	def categories_tags
		category = Category.find_by name: params[:song_category]
		
		tag1 = Tag.find_by(name: params[:song_tag1][:Cool]) unless params[:song_tag1][:Cool] == "no"
		tag2 = Tag.find_by(name: params[:song_tag2][:Hard]) unless params[:song_tag2][:Hard] == "no"
		tag3 = Tag.find_by(name: params[:song_tag3][:Begginer]) unless params[:song_tag2][:Begginer] == "no"

		@song.categories << category if category
		@song.tags << tag1 if tag1
		@song.tags << tag2 if tag2
		@song.tags << tag3 if tag3
	end
end
