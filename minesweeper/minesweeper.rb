class Board
  attr_accessor :grid

  def self.transform(values)
    # ["+------+", "|1*22*1|", "|12*322|",
      # "| 123*2|", "|112*4*|", "|1*22*2|", "|111111|", "+------+"]
      # require 'pry';binding.pry
    new(values).condense
  end

  def initialize(values)
    destroy = values.dup
    validate(destroy)
    @grid = populate_grid(values)
    add_mine_counts
  end

  def validate(values)
    if !row_lengths_same?(values)
      raise ValueError, "Not all row lengths are equal"
    end
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

  def populate_grid(values)
    values.map { |row| row.chars }
  end

  def add_mine_counts
    grid.length.times do |row|
      grid.first.length.times do |column|
        if grid[row][column] == ' '
          count = mines_for([row, column])
          grid[row][column] = count if count > 0
        end
      end
    end
  end

  def condense
    grid.map { |row| row.join }
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

class ValueError < Exception
end