class InstrumentsController < ApplicationController
	before_action :set_instrument, only: [:show]

	def index
		@instruments = Instrument.all
	end

	def show
		@songs = @instrument.songs
	end
	def new
		@instrument = Instrument.new
	end
	def create
		@instrument = Instrument.new entry_params
		if @instrument.save 
			flash[:notice] = 'Your instrument has been created!'
			redirect_to action: 'index', controller: 'instruments'	
		else 
			flash[:notice] = 'Ooohps, your instrument could not be created, try again'
			render 'new'	
		end	
	end 

	protected

	def set_instrument
	  @instrument = Instrument.find(params[:id])
	end

	def entry_params
		params.require(:instrument).permit(:name)
	end
end