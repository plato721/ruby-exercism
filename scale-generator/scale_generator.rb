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
    []
  end

  def name
    self.tonic.capitalize + " " + self.type.to_s
  end

  def pitches
    all_pitches_sharps if type == :chromatic

  end


end