class Scale
  attr_reader :tonic, :type, :intervals

  def initialize(tonic, type, intervals=nil)
    @tonic = tonic.capitalize
    @type = type.to_sym
    @intervals = intervals || "m" * 12
  end

  def notes
    @notes ||= self.send(sharps_or_flats)
  end

  def offset
    @offset ||= self.notes.index(self.tonic)
  end

  def sharps
    ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  end

  def flats
    ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  end

  def sharp_keys
    ['C','C#','D','D#','E','F#','G','G#','A','A#','B']
  end

  def sharps_or_flats
    return :flats if type == :locrian || type == :harmonic_minor
    return :sharps if sharp_keys.include?(self.tonic)
    :flats
  end

  def name
    self.tonic.capitalize + " " + self.type.to_s
  end

  def pitches
    self.send(type)
  end

  def permitted_scales
    [:major, :minor, :harmonic_minor, :pentatonic, :mixolydian, :dorian,
      :enigma, :hexatonic, :octatonic, :locrian, :phrygian, :lydian,
      :chromatic]
  end

  def method_missing(m, *args)
    super if !permitted_scales.include?(m)
    self.scale
  end

  def scale
    [*0..(self.intervals.length - 1)].each_with_object([]) do |count, scale|
      scale << next_note(count)
    end
  end

  private
  def convert_whole(steps)
    steps.count("M") * 2
  end

  def convert_half(steps)
    steps.count("m")
  end

  def convert_augmented(steps)
    steps.count("A") * 3
  end

  def relative_index(count)
    steps = intervals.slice(0, count)
    convert_whole(steps) + convert_half(steps) + convert_augmented(steps)
  end

  def absolute_index(count)
    (relative_index(count) + self.offset) % sharps.length
  end

  def next_note(count)
    self.notes[absolute_index(count)]
  end
end
