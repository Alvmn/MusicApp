class SongsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :found_songs] #autenticate! es una función creada por nosotros, más abajo
  before_action :set_instrument

  def index
    @songs = @instrument.songs
    @q = @instrument.songs.search(params[:q])
 	@result = @q.result(distinct: true)
  end
  
  def show
    @instrument = Instrument.friendly.find params[:instrument_id]
    @song = @instrument.songs.friendly.find params[:id]
    @midis = @song.midis
    @videos = @song.videos
    @comments = @song.comments.order(created_at: :desc).limit(10)
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
    @tags       = Tag.all
    @song = @instrument.songs.new
    authorize @song
  end

  def create
  	@tags = Tag.all
    @song = @instrument.songs.new
    # binding.pry
    @song.assign_attributes(song_params)
    authorize @song
    
    if @song.save
  	  categories_tags #Esto llama a la función categories tag de abajo/ no borrar xd
  	  youtube_link = @song.videos.create url: params[:youtube_link]
  	  midi_link = @song.midis.create url: params[:midi_link]
      music_sheet_assignment
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
  	  if song.midis.first != nil
        song.midis.first.update url: params[:midi_link]
      else
        song.midis.create url: params[:midi_link]
      end 
      @song = @instrument.songs.friendly.find params[:id]
      authorize @song
  # youtube_videos = song.videos.update
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
    	:title, :youtube_link,:music_sheets, :songwriter, :tag_ids, tags_attributes: [:name, :id])
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

  def music_sheet_assignment
    music_sheet = params[:song][:music_sheets]
    @song.music_sheets = music_sheet if music_sheet
  end
end
