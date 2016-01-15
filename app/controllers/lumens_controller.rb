require 'reloader/sse'

class LumensController < ApplicationController
	include ActionController::Live

	def index
		@lumens = Lumen.all
	end

	def stream
		
	end

	def event_stream
		response.headers['Content-Type'] = 'text/event-stream'

		sse = Reloader::SSE.new(response.stream)

		last_updated = Lumen.last_updated.first
		if recently_changed? last_updated
		  begin
		    sse.write(last_updated, event: 'reading')
		  rescue IOError
		    # When the client disconnects, we'll get an IOError on write
		  ensure
		    sse.close
		  end
		end
	end

	def create

		respond_to do |format|
			format.json do

				@lumen = Lumen.new(lumen_params)
				
				if @lumen.save
					head :created
				end

			end
		end

	end

	private
	def lumen_params
	 	params.require(:lumen).permit(:data)
	end

	def recently_changed? last_reading
	  last_reading.created_at > 5.seconds.ago or last_reading.updated_at > 5.seconds.ago
	end
end
