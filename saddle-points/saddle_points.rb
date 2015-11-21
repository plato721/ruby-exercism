class Matrix
  include Enumerable
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def rows
    rows ||= raw.split("\n").map do |row| 
      row.split(" ").map(&:to_i)
    end
  end

  def columns
    columns ||= rows.transpose
  end

  def length
    length ||= rows[0].length
  end

  def height
    height ||= columns[0].length
  end

  def saddle_points
    self.select { |coords| is_saddle?(coords) }
  end

  def is_saddle?(coords)
    rows[coords.first].max == value_at(coords) &&
    columns[coords.last].min == value_at(coords)
  end

  def value_at(coords)
    rows[coords.first][coords.last]
  end

  def each
    self.height.times do |x|
      self.length.times do |y|
        yield([x, y])
      end
    end
  end
end