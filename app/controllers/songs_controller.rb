class SongsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :found_songs, :music_sheets] #autenticate! es una función creada por nosotros, más abajo
  before_action :set_instrument

  def index
    @songs = @instrument.songs
    @q = @instrument.songs.search(params[:q])
 	  @result = @q.result(distinct: true)
  end
  
  def show
    if params[:instrument_id]
      @song = @instrument.songs.friendly.find params[:id] 
    else
      @song = Song.find params[:id]
    end
    @midis = @song.midis
    @videos = @song.videos
    @comments = @song.comments.order(created_at: :desc).limit(10)
    track_search = RSpotify::Track.search(@song.title)
    @track = track_search.first if track_search
    # binding.pry
  end
  
  def found_songs
    @songs = @instrument.songs.where "title LIKE ?", "%#{params[:title]}%" if params[:title]
    @songs = @instrument.songs.where "songwriter LIKE ?", "%#{params[:songwriter]}%" if params[:songwriter]
    unless @songs.empty? 
  	  render 'found_songs'
    else 
      flash[:alert] = 'Ooohps! We could not find your song, did you write it right?'
      redirect_to action:'index'
    end	
  end

  def new
    @categories = Category.all
    @tags       = Tag.all
    @song = @instrument.songs.new
    authorize @song
  end

  def create
  	@tags = Tag.all
    @song = @instrument.songs.new
    # binding.pry
    @song.assign_attributes(song_params)
    @song.user = current_user
    authorize @song
    
    if @song.save
  	  categories_tags #Esto llama a la función categories tag de abajo/ no borrar xd
  	  youtube_link = @song.videos.create url: params[:youtube_link]
      if params[:song][:music_sheet] #No lleva :sheet file porque si no introduces nada en el archivo
        # te dará nil tal y como está puesto y nil[:sheet_file] no es algo posible
        params[:song][:music_sheet][:sheet_file].each do |sheet|
          @song.music_sheets.create sheet_file: sheet
        end
      end
      if params[:song][:audio] #No lleva :audio_file porque si no introduces nada en el archivo
        # te dará nil tal y como está puesto y nil[:audio_file] no es algo posible
        midi =params[:song][:audio][:audio_file] 
        @song.midis.create audio_file: midi
      end
      # binding.pry
      flash[:alert] = "Song succesfully created!"
  	  redirect_to action: 'index', controller: 'songs'
    else
  	  flash[:alert] = "Sorry, try again"
  	  @categories = Category.all
  	  render 'new'
    end
  end

  def edit
    @tags = Tag.all
    @song = @instrument.songs.friendly.find params[:id]
    @videos = @song.videos
    @midis = @song.midis
    @categories = Category.all
# AÑADIR POSIBILIDAD DE AÑADIR O QUITAR TAGS
    authorize @song
  end

  def update
    song = @instrument.songs.friendly.find params[:id]
    song.update song_params
    authorize song
    if song.valid?
      if song.categories.first != nil
       new_song_category = Category.find_by name: params[:song_category]
       song.categories = []
       song.categories << new_song_category
       #Así está planteado para que sólo haya una categoría pero en un futuro se puede cambiar para 
       # que haya más de una categoría por canción
      else
        new_song_category = Category.find_by name: params[:song_category]
        song.categories << new_song_category if new_song_category
      end 
      if song.videos.first != nil
        song.videos.first.update url: params[:youtube_link]
      else
        song.videos.create url: params[:youtube_link]
      end 
  	  if song.midis.first != nil # CAMBIAR LUEGO SI ESO PARA AÑADIR MÁS MIDIS
        song.midis.first.update url: params[:midi_link]
      else
        song.midis.create url: params[:midi_link]
      end 
      if params[:song][:music_sheet] 
        params[:song][:music_sheet][:sheet_file].each do |sheet|
          song.music_sheets.create sheet_file: sheet
        end
      else

      end
       # AÑADE OTRA PARTITURA
      @song = @instrument.songs.friendly.find params[:id]
      authorize @song
  # youtube_videos = song.videos.update
      redirect_to action: 'index', controller: 'songs'
    else
      render 'edit'
    end
  end
  def show_sheet

  end

  def destroy
    @song = @instrument.songs.friendly.find params[:id]
    @youtube_videos = @song.videos
    @midis = @song.midis
    authorize @song

    if @song.destroy && @youtube_videos.destroy && @midis.destroy
      flash[:alert] = "Song succesfully deleted!"
      redirect_to action: 'index', controller: 'songs'
    # ESTOS DOS SON PARA EL DESTROY DEL EDIT
    elsif @youtube_videos.destroy 
      flash[:alert] = "Video succesfully deleted!"
      redirect_to action: 'edit', controller: 'songs'
    elsif @midis.destroy
      flash[:alert] = "MIDI succesfully deleted!"
      redirect_to action: 'edit', controller: 'songs'
    else
      flash[:alert] = "Song NOT deleted!"
      redirect_to action: 'index', controller: 'songs'
    end
  end

  def music_sheets
    @instrument = Instrument.friendly.find params[:instrument_id]
    @song = @instrument.songs.friendly.find params[:id]
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access private data
    spotify_user.country #=> "US"
    spotify_user.email   #=> "example@email.com"

    # Create playlist in user's Spotify account
    playlist = spotify_user.create_playlist!('my-awesome-playlist')

    # Add tracks to a playlist in user's Spotify account
    tracks = RSpotify::Track.search('Know')
    playlist.add_tracks!(tracks)
    playlist.tracks.first.name #=> "Somebody That I Used To Know"

    # Access and modify user's music library
    spotify_user.save_tracks!(tracks)
    spotify_user.saved_tracks.size #=> 20
    spotify_user.remove_tracks!(tracks)

    # Check doc for more
  end

protected

  def set_instrument
    @instrument = Instrument.friendly.find params[:instrument_id] if params[:instrument_id]
  end

  def authenticate!
    authenticate_admin! || authenticate_user!
    @current_user = admin_signed_in? ? current_admin : current_user
  end

  def categories_tags
    category = Category.find_by name: params[:song_category]
    # tag1 = Tag.find_by(name: params[:song_tag1][:Cool]) unless params[:song_tag1][:Cool] == "no"
    # tag2 = Tag.find_by(name: params[:song_tag2][:Hard]) unless params[:song_tag2][:Hard] == "no"
    # tag3 = Tag.find_by(name: params[:song_tag3][:Begginer]) unless params[:song_tag2][:Begginer] == "no"

    @song.categories << category if category
    # @song.tags << tag1 if tag1
    # @song.tags << tag2 if tag2
    # @song.tags << tag3 if tag3
  end

  def song_params
    params.require(:song).permit(
    	:title, :youtube_link,:music_sheets,:asheet, :songwriter, :tag_ids, tags_attributes: [:name, :id])
  end

  def categories_assignment
    category = Category.find_by name: params[:categories]
    @song.categories << category if category
  end

  def video_assignment
    video = Video.find_by url: params[:youtube_link]
    @song.videos << video if video
  end

  def midi_assignment
    midi = Midi.find_by url: params[:midi_link]
    @song.midis << midi if midi
  end
end 
