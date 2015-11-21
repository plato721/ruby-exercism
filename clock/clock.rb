class Clock
  attr_accessor :hours, 
                :minutes

  def initialize(*args)
    self.hours = args[0]
    self.minutes = args[1] || 0
  end

  def self.at(*args)
    Clock.new(*args)
  end

  def normalize_minutes
    until minutes < 60
      self.hours += 1
      self.minutes -= 60
    end
    until minutes >= 0
      self.hours -= 1
      self.minutes += 60
    end
  end

  def normalize_hours
    self.hours += 24 until hours > 0
    self.hours -= 24 until hours < 24
  end

  def +(mins)
    self.minutes += mins
    normalize_minutes
    normalize_hours
    self
  end

  def -(mins)
    self.+(-mins)
  end

  def ==(other)
    self.hours == other.hours &&
    self.minutes == other.minutes
  end

  def to_s
    self.hours.to_s.rjust(2, "0") +
      ":" +
    self.minutes.to_s.rjust(2, "0")
  end

end