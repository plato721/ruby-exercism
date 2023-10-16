class Darts
  attr_reader :x, :y

  INNER_RING_DISTANCE = 1.0
  MIDDLE_RING_DISTANCE = 5.0
  OUTER_RING_DISTANCE = 10.0

  def initialize(x, y)
    @x = x
    @y = y
  end

  def score
    return 0 unless distance_from_center <= OUTER_RING_DISTANCE

    point_map.each do |ring_boundary, points|
      return points if distance_from_center <= ring_boundary
    end
  end

  private

  def point_map
    { INNER_RING_DISTANCE => 10,
      MIDDLE_RING_DISTANCE => 5,
      OUTER_RING_DISTANCE => 1 }
  end

  def distance_from_center
    Math.sqrt(x**2 + y**2)
  end
end
