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

	protected

	def set_song
		@song = Song.find params[:song_id]
	end
end
