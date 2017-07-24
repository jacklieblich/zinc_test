class MacbethAnalyzersController < ApplicationController

	def new
	end

	def count
		macbeth_analyzer = MacbethAnalyzer.new(params[:url])
		@sorted_speakers = macbeth_analyzer.sort_speakers
	end
	
end
