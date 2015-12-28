class Scale
  attr_reader :tonic, :type, :intervals

  def initialize(tonic, type, intervals=nil)
    @tonic = tonic.capitalize
    @type = type.to_sym
    @intervals = intervals || "m" * 12
  end

  def all_pitches_sharps
    ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  end

  def all_pitches_flats
    ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  end

  def sharps_or_flats
    return :all_pitches_flats if type == :locrian || type == :harmonic_minor
    if ['C','C#','D','D#','E','F#','G','G#','A','A#','B'].include?(self.tonic)
      :all_pitches_sharps
    else
      :all_pitches_flats
    end
  end

  def name
    self.tonic.capitalize + " " + self.type.to_s
  end

  def pitches
    self.send(type)
  end

  def whole_steps(steps)
    steps.count("M") * 2
  end

  def half_steps(steps)
    steps.count("m")
  end

  def augmented(steps)
    steps.count("A") * 3
  end

  def note_index(count)
    steps = intervals.slice(0, count)
    whole_steps(steps) + half_steps(steps) + augmented(steps)
  end

  def method_missing(m, *args)
    self.scale
  end

  def scale
    notes = sharps_or_flats
    offset = self.send(notes).index(self.tonic)
    [*0..(self.intervals.length - 1)].each_with_object([]) do |count, scale|
      index = (note_index(count) + offset) % all_pitches_sharps.length
      scale << self.send(notes)[index]
    end
  end

end