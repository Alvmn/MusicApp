class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_song

  def new
    @comment = @song.comments.new
    authorize @comment
  end

  def create
    @comment = @song.comments.create(content: params[:content], username: params[:username])
    @comment.user = current_user
    authorize @comment
    if @comment.save
      redirect_to action:'show', controller:'songs', id: @song.slug
    else
      render 'new'
    end
  end

  def destroy
    @comment = @song.comments.find params[:id]
    authorize @comment
    if @comment.destroy
      flash[:notice]
      redirect_to action:'show', controller:'songs', instrument_id: params[:instrument_id], id: @song.slug
    else
      redirect_to action:'show', controller:'songs', instrument_id: @instrument.slug, id: @song.slug
    end
  end

  def edit
    @comment = @song.comments.find params[:id]
    authorize @comment
  end

  def update
    @comment = @song.comments.find params[:id]
    authorize @comment
    @comment.update content: params[:content]
    

    if @comment.valid?
      redirect_to action: 'show', controller: 'songs', instrument_id: params[:instrument_id], id: @song.slug
    else
      render 'edit'
    end
  end

  protected

  def set_song
    @song = Song.friendly.find params[:song_id]
  end
end