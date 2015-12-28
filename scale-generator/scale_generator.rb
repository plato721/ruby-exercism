class Scale
  attr_reader :tonic, :type, :intervals

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

  def whole_steps(steps)
    steps.count("M") * 2
  end

  def half_steps(steps)
    steps.count("m")
  end

  def note_index(count)
    steps = intervals.slice(0, count)
    whole_steps(steps) + half_steps(steps)
  end

  def major
    notes = sharps_or_flats
    offset = self.send(notes).index(self.tonic)
    [*0..(self.intervals.length - 1)].each_with_object([]) do |count, scale|
      index = (note_index(count) + offset) % all_pitches_sharps.length
      scale << self.send(notes)[index]
    end
  end

  def chromatic
    offset = all_pitches_sharps.index(tonic)
    [*0..(all_pitches_sharps.length - 1)].each_with_object([]) do |count, scale|
      index = (count + offset) % all_pitches_sharps.length
      scale << self.send(sharps_or_flats)[index]
    end
  end

  def pitches
    self.send(type)
  end


end