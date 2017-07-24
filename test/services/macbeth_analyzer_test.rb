require 'test_helper'
require 'nokogiri'

class MacbethAnalyzerTest < ActiveSupport::TestCase

	def setup
		speaker_count = rand(1..100)
		speaker_line_count = Array.new(speaker_count) do |i|
			i = rand(1..1000)
		end
		speaker_lines = {}


		@builder = Nokogiri::XML::Builder.new do |xml|
			xml.root do
				xml.play "play name" do
					speaker_count.times do |i|
						speaker_lines[i.to_s] = speaker_line_count[i]
						xml.SPEECH do
							xml.SPEAKER i
							speaker_line_count[i].times do 
								xml.LINE "this is a line"
							end
						end
					end
				end
			end
		end
		@sorted_speaker_lines = speaker_lines.sort_by { |speaker, lines| lines }.reverse
	end

	def test_sorted_speakers
		assert_equal(@sorted_speaker_lines, MacbethAnalyzer.new(@builder.to_xml, false).sort_speakers)
	end

end