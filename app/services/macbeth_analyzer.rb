require 'nokogiri'
require 'open-uri'

class MacbethAnalyzer

  def initialize(input, link=true)
    if link
      @doc = Nokogiri::XML(open(input))
    else
      @doc = Nokogiri::XML(input)
    end
    @sorted_speakers = []
    @speaker_lines = {}
  end

  def sort_speakers
    speeches = @doc.xpath("//SPEECH")
    speeches.each do |speech|
      line_count = speech.xpath(".//LINE").length

      speech.xpath(".//SPEAKER").each do |speaker|
        unless speaker.content == "ALL"
          if @speaker_lines[speaker.content] == nil
            @speaker_lines[speaker.content] = line_count
          else
            @speaker_lines[speaker.content] += line_count
          end
        end
      end

    end
    sorted_speaker_lines = @speaker_lines.sort_by { |speaker, lines| lines }.reverse
    return sorted_speaker_lines
  end

end