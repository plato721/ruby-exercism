class Darts
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def score
    case distance_from_center
    when 0..1.0
      10
    when 1..5.0
      5
    when 5..10.0
      1
    else
      0
    end
  end

  private

  def distance_from_center
    Math.sqrt(x**2 + y**2)
  end
end
