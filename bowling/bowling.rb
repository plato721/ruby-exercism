class Game
  attr_accessor :score

  def initialize
    self.score = 0
  end

  def roll(pins)
    self.score += pins
  end
end