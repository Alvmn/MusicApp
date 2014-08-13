class SongsController < ApplicationController
	before_action :set_instrument
	def index
		@songs = @instrument.songs
	end
	def show
		@song = @instrument.songs.find params[:id]
	end
	protected

	def set_instrument
	  @instrument = Instrument.find params[:instrument_id]
	end
end
