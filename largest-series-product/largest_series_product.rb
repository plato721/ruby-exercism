class Series
  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence.chars.map(&:to_i)
  end

  def largest_product(length)
    sequence.inject(:*)
  end
end