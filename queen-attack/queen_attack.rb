class Queens
  attr_reader :white, :black, :board

  def initialize(placement = defaults)
    raise ArgumentError if placement[:white] == placement[:black]
    placement.merge(defaults)
    @white = placement[:white]
    @black = placement[:black]
    @board = build_board
  end

  def length
    8
  end

  def width
    8
  end

  def attack?
    co_horizontal? || co_vertical? || co_diagonal?
  end

  def to_s
    rows = self.board.map { |row| row.join(" ") }
    rows.join("\n")
  end
  
  private
  def defaults
    { white: [0, 3],
      black: [7, 3] }
  end

  def build_board
    board = Array.new(length){ Array.new(width){ "_" } }
    board[white.first][white.last] = 'W'
    board[black.first][black.last] = 'B'
    board
  end

  def co_horizontal?
    white.last == black.last
  end

  def co_vertical?
    white.first == black.first
  end

  def co_diagonal?
    (white.first - black.first).abs == (white.last - black.last).abs
  end

end