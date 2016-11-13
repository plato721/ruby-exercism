class Game
  attr_accessor :score, :rolls

  def initialize
    self.score = 0
    self.rolls = []
  end

  def roll(pins)
    self.rolls << pins
    self.score += pins
    self.score += pins if on_spare?
  end

  def on_spare?
    return false if rolls.count < 3
    rolls[-2] + rolls[-3] == 10
  end
end