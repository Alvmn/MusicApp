class CommentsController < ApplicationController
	before_action :set_song

	def new
		@comment = @song.comments.new
	end

	def create
		@comment = @song.comments.new(content: params[:comment_content])
		if @comment.save
			redirect_to action: 'show', controller:'comments', comment_id: @comment.id
		else
			render 'new'
		end
	end

	protected

	def set_song
		@song = Song.find params[:somg_id]
	end
end
