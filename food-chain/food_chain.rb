module FoodChain
  FILE_NAME = 'song.txt'
  VERSION = 1

  def self.song
    File.open(FILE_NAME) do |file|
      # --uncomment next two lines if you want to see any output--
      # puts "#{file.read}"
      # file.seek(0)
      file.read
      end
    end
  end

