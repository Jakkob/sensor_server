class LumensController < ApplicationController

	def index
		@lumens = Lumen.all

	end

	def create
		#@lumen = Lumen.new

		

		respond_to do |format|
			format.json do

				@lumen = Lumen.new(lumen_params)
				
				if @lumen.save
					head :created
				end

			end
		end
		#@lumen = Lumen.new(lumen_params)

		# @lumen.data = :reading

	end

	private
	def lumen_params
	 	params.require(:lumen).permit(:data)
	end
end
