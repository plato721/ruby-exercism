module Grains
  BOARD_WIDTH = 8
  BOARD_SQUARES = BOARD_WIDTH ** 2

  def self.square(n)
    raise ArgumentError unless (1..BOARD_SQUARES).include?(n)
    2 ** (n - 1)
  end

  def self.total
    (1..BOARD_SQUARES).inject { |sum, n| sum + square(n) }
  end
end