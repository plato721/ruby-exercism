require 'pry'

class Binary < String
  VERSION = 1

  attr_reader :to_decimal

  def initialize(bin)
    super(bin)
    @to_decimal = calc_decimal
  end

  private

  def calc_decimal
    each_char.reduce(0) do |acc, c|
      fail ArgumentError unless %w(1 0).member? c
      # binding.pry;
      (acc << 1) + c.to_i
    end
  end
end