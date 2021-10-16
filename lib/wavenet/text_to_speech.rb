require_relative "env"

DEFAULT_TEXT = "1 2 3, prova! 1 2 3, prova!"
# DEFAULT_TEXT = "Aggiungi un posto a tavola, che c'e' un amico in piu' , se sposti un po' la seggiola, stai comodo anche tu! daai! puoi partire alla graaande, anche tu!"

class TextToSpeech
  TEXT = ENV["TEXT"] || DEFAULT_TEXT

  attr_reader :text, :id

  def initialize
    @client = Google::Cloud::TextToSpeech.text_to_speech
    text = CGI.unescape TEXT
    @text   = text
    @id     = hash str: text
    # puts "TEXT: #{text}"
    # puts "ID: #{@id}"
  end

  def self.speak
    new.speak
  end

  def speak
    response = @client.synthesize_speech(
      input:        synthesis_input,
      voice:        VOICE_CFG,
      audio_config: audio_config
    )

    File.open("#{OUTPUT_FILE_PATH}/#{@id}.mp3", "wb") do |file|
      file.write response.audio_content
    end

    # puts "Audio files written"
  end

  private

  def synthesis_input
    text_to_speech_text = transform_italian_accents text: @text
    {
      text: text_to_speech_text,
    }
  end

  def audio_config
    {
      audio_encoding: Google::Cloud::TextToSpeech::V1::AudioEncoding::MP3,
      speaking_rate:  0.9,
    }
  end

  def hash(str:)
    id = Digest::SHA1.hexdigest str
    id[0..7]
  end
end

if __FILE__ == $0
  TextToSpeech.speak
end
