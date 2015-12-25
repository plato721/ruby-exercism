class TwelveDays
  VERSION = 1

  def self.song
    song_file = File.expand_path('../song.txt', __FILE__)
    song = File.read(song_file)
  end
end