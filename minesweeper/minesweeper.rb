class Board
  attr_accessor :grid

  def self.transform(values)
    new(values).condense
  end

  def initialize(values)
    validator = BoardValidator.new(values.dup)
    validator.validate
    @grid = populate_grid(values)
    add_mine_counts
  end

  def condense
    grid.map { |row| row.join }
  end

  def populate_grid(values)
    values.map { |row| row.chars }
  end

  def add_mine_counts
    grid.length.times do |row|
      grid.first.length.times do |column|
        process_mines(grid: grid, row: row, column: column)
      end
    end
  end

  def process_mines(args)
    cell = args[:grid][args[:row]][args[:column]]
    add_mine_count(args) if cell == ' '
  end

  def add_mine_count(args)
    count = mines_for([args[:row], args[:column]])
    args[:grid][args[:row]][args[:column]] = count if count > 0
  end

  def mines_for(coords)
    neighbors = on_board(neighbor_coords(coords))
    neighbors.map do |coords|
      grid[coords.first][coords.last] == '*' ? 1 : 0
    end.inject(:+)
  end

  def neighbor_coords(coords)
    [[coords.first - 1, coords.last - 1],
    [coords.first - 1, coords.last],
    [coords.first - 1, coords.last + 1],
    [coords.first, coords.last - 1],
    [coords.first, coords.last + 1],
    [coords.first + 1, coords.last - 1],
    [coords.first + 1, coords.last],
    [coords.first + 1, coords.last + 1]]
  end

  def on_board(coord_group)
    coord_group.select do |coords|
      coords.first >= 0 && coords.last >= 0
    end
  end
end

class BoardValidator
  attr_reader :values

  def initialize(values)
    @values = values
  end

  def validate(values = self.values)
    check_row_lengths
    check_borders
  end

  def check_row_lengths
    if !row_lengths_same?(values)
      raise ValueError, "Not all row lengths are equal"
    end
  end

  def check_borders
    if !borders_proper?(values)
      raise ValueError, "Borders messed"
    end
  end

  def borders_proper?(values)
    check_top_and_bottom(values) &&
    check_body(values)
  end

  def check_body(values)
    values.shift
    values.pop
    values.each do |row|
      return false if !(row =~ /\|[ \*]+\|/)
    end
    true
  end

  def check_top_and_bottom(values)
    end_piece = /\+-+\+/
    values.first =~ end_piece &&
    values.last =~ end_piece
  end

  def row_lengths_same?(values)
    length = values.first.length
    values.all? { |row| row.length == length }
  end
end

class ValueError < Exception
end