class InstrumentController < ApplicationController
	def index
		@songs = Song.where "instrument = ?", params[:instrument]
	end

	def show
		@song = Song.find params[:id]
	end
end