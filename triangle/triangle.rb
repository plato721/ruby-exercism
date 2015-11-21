class Triangle
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    verify_args([x, y, z])
    @x = x
    @y = y
    @z = z
  end

  def verify_args(tri)
    if tri.min(2).reduce(:+) <= tri.max ||
       tri.any? { |side| side <= 0 }
      raise TriangleError, "This cannot be a triangle"
    end
  end

  def kind
    return :equilateral if x == y && x == z
    return :isosceles if x == y || x == z || y == z
    :scalene
  end
end

class TriangleError < StandardError

end