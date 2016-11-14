class Game
  attr_accessor :frames

  MIN_PINS = 0
  MAX_PINS = 10

  def initialize
    self.frames = [ Frame.new(1) ]
  end

  def roll(pins)
    validate_completion
    validate_pins(pins)
    set_frames
    assign_extras(pins)
    assign_roll(pins)
  end

  def validate_completion
    if game_complete?
      raise StandardError, "Game is already complete."
    end
  end

  def validate_pins(pins)
    check_min(pins)
    check_max(pins)
  end

  def check_min(pins)
    if pins > MAX_PINS
      raise StandardError, "#{pins} pins is above max of #{MAX_PINS}"
    end
  end

  def check_max(pins)
    if pins < MIN_PINS
      raise StandardError, "#{pins} pins is below min of #{MIN_PINS}"
    end
  end

  def set_frames
    count = self.frames.count
    return if count >= 10
    return if self.frames.last.need_roll?
    self.frames << Frame.new(count + 1)
  end

  def assign_roll(pins)
    self.frames.last.roll(pins) if self.frames.last.need_roll?
  end

  def assign_extras(pins)
    self.frames.select{ |frame| frame.need_extra? }
               .each{ |frame| frame.extra(pins) }
  end

  def score
    validate_game_complete
    self.frames.reduce(0) do |acc, frame|
      acc + frame.score
    end
  end

  def validate_game_complete
    if !game_complete?
      raise StandardError, "Cannot score incomplete game"
    end
  end

  def game_complete?
    (self.frames.count == 10) &&
    !self.frames.last.need_roll? &&
    !self.frames.last.need_extra?
  end
end

class BookKeeping
  VERSION = 2
end

class Frame
  attr_accessor :spare, :strike, :roll_1, :roll_2, :extra_1, :extra_2, :number

  def initialize(number)
    raise ArgumentError if number > 10
    self.number = number
  end

  def roll(pins)
    validate_roll(pins)
    !self.roll_1 ? self.roll_1 = pins : self.roll_2 = pins
    check_strike_spare
  end

  def validate_roll(pins)
    if self.roll_1 && self.roll_1 + pins > 10
      raise StandardError, "Exceeds frame maximum"
    end
  end

  def check_strike_spare
    return self.strike = true if is_strike?
    self.spare = true if is_spare?
  end

  def is_strike?
    self.roll_1 == 10
  end

  def is_spare?
    [self.roll_1, self.roll_2].compact.reduce(:+) == 10
  end

  def extra(pins)
    validate_extra(pins)
    !self.extra_1 ? self.extra_1 = pins : self.extra_2 = pins
  end

  def validate_extra(pins)
    if self.number == 10 &&
       self.strike &&
       self.extra_1 &&
       self.extra_1 != 10 &&
       self.extra_1 + pins > 10
      raise StandardError, "Exceeds bonus maximum"
    end
  end

  def need_roll?
    return false if self.roll_1 && self.roll_2
    return false if self.strike
    true
  end

  def need_extra?
    return false if !self.spare && !self.strike
    return false if self.spare && self.extra_1
    return false if self.extra_1 && self.extra_2
    true
  end

  def score
    [self.roll_1, self.roll_2, self.extra_1, self.extra_2].compact.reduce(:+)
  end
end