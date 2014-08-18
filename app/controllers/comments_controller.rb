class CommentsController < ApplicationController
	before_action :set_song

	def new
		@comment = @song.comments.new
		authorize @comment
	end

	def create
		@comment = @song.comments.create(content: params[:content])
		authorize @comment
		if @comment.save
			redirect_to action:'show', controller:'songs', id: @song.id
		else
			render 'new'
		end
	end

	def destroy
		@comment = @song.comments.find params[:id]
		authorize @comment
		if @comment.destroy
			flash[:notice]
			redirect_to action:'show', controller:'songs', song_id: @song.id
		else
			redirect_to action:'show', controller:'songs', song_id: @song.id
		end
	end

	def edit
		@comment = @song.comments.new
		authorize @comment
	end

	def update

	end

	protected

	def set_song
		@song = Song.find params[:song_id]
	end
end
