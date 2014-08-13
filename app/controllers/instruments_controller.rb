class InstrumentsController < ApplicationController
	before_action :set_instrument, only: [:show]

	def index
		@instruments = Instrument.all
	end

	def show
		@songs = @instrument.songs
	end

	protected

	def set_instrument
	  @instrument = Instrument.find(params[:id])
	end
end