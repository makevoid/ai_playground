# TODO: page reenders <audio autoplay> tag with hash of text

class WaveNet
  attr_reader :text, :id

  def initialize(text:)
    @text = text.strip
    @id   = hash str: @text
    # puts "TEXT: #{@text}"
    # puts "ID: #{@id}"
  end

  def self.synthesize_speech(text:)
    new(text: text).synthesize_speech
  end

  def synthesize_speech
    text = CGI.escape @text
    puts `cd #{PATH}/lib/wavenet && BUNDLE_GEMFILE=./Gemfile TEXT="#{text}" bundle exec ruby text_to_speech.rb`
    cleanup_old_files
  end

  def audio_path_public
    "/wavenet/#{@id}.mp3"
  end

  private

  def cleanup_old_files
    files = Dir.glob "#{path}/*.mp3"
    files.map! { |file| Pathname.new file }
    files.sort_by! { |file| file.mtime }
    files.reverse!
    files = files[9..-1]
    return unless files
    files.each{ |file| file.delete }
    true
  end

  def path
    "#{PATH}/public/wavenet"
  end

  def hash(str:)
    id = Digest::SHA1.hexdigest str
    id[0..7]
  end
end
