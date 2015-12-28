class Scale
  attr_reader :tonic, :type

  def initialize(tonic, type, intervals=nil)
    @tonic = tonic
    @type = type
    @intervals = intervals
  end

  def all_pitches_sharps
    ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  end

  def all_pitches_flats
    ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  end

  def name
    self.tonic.capitalize + " " + self.type.to_s
  end

  def sharps_or_flats
    if ['C','C#','D','D#','E','F#','G','G#','A','A#','B'].include?(self.tonic)
      :all_pitches_sharps
    else
      :all_pitches_flats
    end
  end

  def chromatic
    offset = all_pitches_sharps.index(tonic)
    # scale = []
    [*0..(all_pitches_sharps.length - 1)].each_with_object([]) do |count, scale|
      index = (count + offset) % all_pitches_sharps.length
      scale << self.send(sharps_or_flats)[index]
    end
    # scale
  end

  def pitches
    self.send(type)
  end


end