class Series
  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence.chars.map(&:to_i)
  end

  def slice_valid?(length)
    length <= sequence.length
  end

  def validate_slice(length)
    if !slice_valid?(length)
      raise ArgumentError,
        "Must choose slice at most length of sequence (#{sequence.length})"
    end
  end

  def largest_product(length)
    validate_slice(length)
    max = 1
    sequence.each_with_index do |num, idx|
      cur = sequence.slice(idx...(idx + length)).inject(:*)
      max = cur if cur > max
    end
    max
  end
end
